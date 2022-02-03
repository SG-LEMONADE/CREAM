import React, {
	FunctionComponent,
	useState,
	useCallback,
	useEffect,
} from "react";
import { useRouter } from "next/router";
import useSWR from "swr";

import Footer from "components/organisms/Footer";
import HeaderMain from "components/organisms/HeaderMain";
import HeaderTop from "components/organisms/HeaderTop";
import HomeTemplate from "components/templates/HomeTemplate";
import ShopTemplate from "components/templates/ShopTemplate";
import ProductThumbnail from "components/organisms/ProductThumbnail";
import Modal from "components/molecules/Modal";
import ProductSmallInfo from "components/molecules/ProductSmallInfo";
import ProductSizeSelectGrid from "components/molecules/ProductSizeSelectGrid";
import { validateUser } from "utils/user";
import { fetcher } from "lib/fetcher";
import { ProductInfoRes } from "types";
import axios from "axios";

const Search: FunctionComponent = () => {
	const router = useRouter();

	const [isOpen, setIsOpen] = useState<boolean>(false);
	const [searchResult, setSearchResult] = useState<ProductInfoRes[]>([]);
	const [pickedProductInfo, setPickedProductInfo] = useState<ProductInfoRes>();

	const { data, error, mutate } = useSWR<ProductInfoRes[]>(
		`${process.env.END_POINT_PRODUCT}/products?cursor=0&perPage=40`,
		fetcher,
	);

	const onHandleClickWish = useCallback(async (obj: ProductInfoRes) => {
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

	useEffect(() => {
		setSearchResult(data);
	}, [data, pickedProductInfo]);

	return (
		<HomeTemplate
			headerTop={<HeaderTop />}
			headerMain={<HeaderMain />}
			footer={<Footer />}
		>
			<ShopTemplate>
				{searchResult &&
					searchResult.map((obj) => (
						<ProductThumbnail
							key={obj.id}
							category="shop"
							productInfo={obj}
							isWishState={obj.wishList !== null}
							onHandleWishClick={() => {
								onHandleClickWish(obj);
							}}
						/>
					))}
			</ShopTemplate>
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
		</HomeTemplate>
	);
};

export default Search;
