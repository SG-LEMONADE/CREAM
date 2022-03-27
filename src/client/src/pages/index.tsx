import React, {
	FunctionComponent,
	useState,
	useEffect,
	useCallback,
	useContext,
} from "react";
import useSWR from "swr";
import { fetcher, fetcherWithToken } from "lib/fetcher";
import { HomeProductInfoRes, HomeRes } from "types";
import axios from "axios";
import { useRouter } from "next/router";

import NavTemplate from "components/templates/NavTemplate";
import HeaderTop from "components/organisms/HeaderTop";
import HeaderMain from "components/organisms/HeaderMain";
import Footer from "components/organisms/Footer";
import HomeTemplate from "components/templates/HomeTemplate";
import HomeProduct from "components/organisms/HomeProduct";
import Modal from "components/molecules/Modal";
import ProductSmallInfo from "components/molecules/ProductSmallInfo";
import Recommendations from "components/organisms/Recommendations";
import ProductSizeSelectGrid from "components/molecules/ProductSizeSelectGrid";
import { validateUser } from "lib/user";
import { getToken } from "lib/token";

import { Oval } from "react-loader-spinner";
import UserContext from "context/user";

const Home: FunctionComponent = () => {
	const router = useRouter();
	const { user, setUser } = useContext(UserContext);

	const [isOpenWishModal, setIsOpenWishModal] = useState<boolean>(false);
	const [userClickedProduct, setUserClickedProduct] =
		useState<HomeProductInfoRes>();

	const { data: homeData, mutate } = useSWR<HomeRes>(
		`${process.env.END_POINT_PRODUCT}`,
		user?.id ? (url) => fetcherWithToken(url, setUser) : fetcher,
		{
			revalidateOnFocus: false,
			errorRetryCount: 5,
		},
	);

	const onHandleUserClickedWish = useCallback(
		async (clickedProduct: HomeProductInfoRes) => {
			try {
				const res = await validateUser(setUser);
				if (!res) {
					router.push("/login");
				} else {
					setIsOpenWishModal(true);
					setUserClickedProduct(clickedProduct);
				}
			} catch (e) {
				router.push("/login");
			}
		},
		[],
	);

	const onPostWish = useCallback(
		async (size: string) => {
			const token = getToken("accessToken");
			try {
				const res = await axios.post(
					`${process.env.END_POINT_PRODUCT}/wish/${userClickedProduct.id}/${size}`,
					{},
					{
						headers: {
							Authorization: `Bearer ${token}`,
						},
					},
				);
				const data = res.data;
				if (data !== "") {
					console.error(
						`Something wrong when posting. error code ${res.status}}`,
					);
				} else {
					toggleUserClickWish(size);
					mutate();
				}
			} catch (err) {
				console.error(err);
				// errResponse.code && alert(`${process.env.ERROR_code[parseInt(errResponse.code)]}`);
			}
		},
		[userClickedProduct],
	);

	const toggleUserClickWish = (size: string) => {
		if (
			userClickedProduct.wishList &&
			userClickedProduct.wishList.includes(size)
		) {
			setUserClickedProduct({
				...userClickedProduct,
				wishList: [
					...userClickedProduct.wishList.filter((data) => data !== size),
				],
			});
		} else {
			userClickedProduct.wishList !== null &&
				setUserClickedProduct({
					...userClickedProduct,
					wishList: [...userClickedProduct.wishList, size],
				});
			userClickedProduct.wishList === null &&
				setUserClickedProduct({
					...userClickedProduct,
					wishList: [size],
				});
		}
	};

	useEffect(() => {
		mutate();
	}, [user]);

	if (!homeData) {
		return (
			<NavTemplate
				headerTop={<HeaderTop />}
				headerMain={<HeaderMain />}
				footer={<Footer />}
			>
				<HomeTemplate isLoading>
					<Oval
						ariaLabel="loading-indicator"
						height={100}
						width={100}
						strokeWidth={5}
						color="black"
						secondaryColor="white"
					/>
				</HomeTemplate>
			</NavTemplate>
		);
	}

	return (
		<NavTemplate
			headerTop={<HeaderTop />}
			headerMain={<HeaderMain />}
			footer={<Footer />}
		>
			<HomeTemplate ads={homeData && homeData.adImageUrls}>
				{homeData && (
					<Recommendations
						productInfos={
							homeData.recommendedItems ? homeData.recommendedItems : []
						}
						onHandleWishClick={onHandleUserClickedWish}
					/>
				)}
				{homeData &&
					homeData.sections.map((product) => (
						<HomeProduct
							key={product.header}
							imageUrl={product.imageUrl}
							bgColor={product.backgroundColor}
							header={product.header}
							detail={product.detail}
							productInfo={product.products}
							onHandleWishClick={onHandleUserClickedWish}
						/>
					))}
			</HomeTemplate>
			<Modal
				category="wish"
				onClose={() => setIsOpenWishModal(false)}
				show={isOpenWishModal}
				title="관심 상품 추가"
			>
				{userClickedProduct && (
					<>
						<ProductSmallInfo
							imgSrc={userClickedProduct.imageUrls[0]}
							backgroundColor={userClickedProduct.backgroundColor}
							productName={userClickedProduct.originalName}
							productNameKor={userClickedProduct.translatedName}
							style={{
								borderBottom: "1px solid #eeeeee",
								paddingBottom: "10px",
								marginBottom: "10px",
							}}
						/>
						<ProductSizeSelectGrid
							category="wish"
							activeSizeOption={
								userClickedProduct.wishList && userClickedProduct.wishList
							}
							datas={userClickedProduct.sizes}
							onClick={(size) => onPostWish(size)}
						/>
					</>
				)}
			</Modal>
		</NavTemplate>
	);
};

export default Home;
