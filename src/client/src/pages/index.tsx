import React, {
	FunctionComponent,
	useState,
	useEffect,
	useCallback,
} from "react";
import useSWR from "swr";
import { fetcher } from "lib/fetcher";
import { HomeProductInfoRes, HomeRes } from "types";
import { validateUser } from "utils/user";
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
import ProductSizeSelectGrid from "components/molecules/ProductSizeSelectGrid";

import { Oval } from "react-loader-spinner";

const Home: FunctionComponent = () => {
	const router = useRouter();

	const [isOpen, setIsOpen] = useState<boolean>(false);
	const [pickedProductInfo, setPickedProductInfo] =
		useState<HomeProductInfoRes>();

	const { data: homeData, mutate } = useSWR<HomeRes>(
		`${process.env.END_POINT_PRODUCT}`,
		fetcher,
		{
			revalidateOnFocus: false,
		},
	);

	const onHandleClickWish = useCallback(async (obj: HomeProductInfoRes) => {
		try {
			const res = await validateUser();
			if (!res) {
				// user Not logined.
				router.push("/login");
			} else {
				setIsOpen(true);
				setPickedProductInfo(obj);
			}
		} catch (e) {
			router.push("/login");
		}
	}, []);

	const onPostWish = useCallback(
		async (size: string) => {
			try {
				const res = await axios.post(
					`${process.env.END_POINT_PRODUCT}/wish/${pickedProductInfo.id}/${size}`,
					{},
					{
						headers: {
							userId: "1",
						},
					},
				);
				const data = res.data;
				if (data !== "") {
					console.error(
						`Something wrong when posting. error code ${res.status}}`,
					);
				} else {
					if (
						pickedProductInfo.wishList &&
						pickedProductInfo.wishList.includes(size)
					) {
						setPickedProductInfo({
							...pickedProductInfo,
							wishList: [
								...pickedProductInfo.wishList.filter((data) => data !== size),
							],
						});
					} else {
						if (pickedProductInfo.wishList !== null) {
							setPickedProductInfo({
								...pickedProductInfo,
								wishList: [...pickedProductInfo.wishList, size],
							});
						} else {
							setPickedProductInfo({ ...pickedProductInfo, wishList: [size] });
						}
					}
					mutate();
				}
			} catch (err) {
				console.error(err);
				// errResponse.code && alert(`${process.env.ERROR_code[parseInt(errResponse.code)]}`);
			}
		},
		[pickedProductInfo],
	);

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
			<HomeTemplate>
				{homeData &&
					homeData.sections.map((product) => (
						<HomeProduct
							key={product.header}
							imageUrl={product.imageUrl}
							bgColor="#eee"
							header={product.header}
							detail={product.detail}
							productInfo={product.products}
							onHandleWishClick={onHandleClickWish}
						/>
					))}
			</HomeTemplate>
			<Modal
				category="wish"
				onClose={() => setIsOpen(false)}
				show={isOpen}
				title="관심 상품 추가"
			>
				{pickedProductInfo && (
					<>
						<ProductSmallInfo
							imgSrc={pickedProductInfo.imageUrls[0]}
							backgroundColor={pickedProductInfo.backgroundColor}
							productName={pickedProductInfo.originalName}
							productNameKor={pickedProductInfo.translatedName}
							style={{
								borderBottom: "1px solid #eeeeee",
								paddingBottom: "10px",
								marginBottom: "10px",
							}}
						/>
						<ProductSizeSelectGrid
							category="wish"
							activeSizeOption={
								pickedProductInfo.wishList && pickedProductInfo.wishList
							}
							datas={pickedProductInfo.sizes}
							onClick={(size) => onPostWish(size)}
						/>
					</>
				)}
			</Modal>
		</NavTemplate>
	);
};

export default Home;
