import React, {
	FunctionComponent,
	useState,
	useCallback,
	useEffect,
	SetStateAction,
} from "react";
import { useRouter } from "next/router";
import useSWRInfinite from "swr/infinite";
import axios from "axios";

import Footer from "components/organisms/Footer";
import HeaderMain from "components/organisms/HeaderMain";
import HeaderTop from "components/organisms/HeaderTop";
import NavTemplate from "components/templates/NavTemplate";
import ShopTemplate, {
	SearchEmptyConent,
	StatusText,
} from "components/templates/ShopTemplate";
import ProductThumbnail from "components/organisms/ProductThumbnail";
import Modal from "components/molecules/Modal";
import ProductSmallInfo from "components/molecules/ProductSmallInfo";
import ProductSizeSelectGrid from "components/molecules/ProductSizeSelectGrid";
import ProductSkeleton from "components/organisms/Skeletons";
import { validateUser } from "lib/user";
import { fetcher } from "lib/fetcher";
import { ProductInfoRes } from "types";
import { queryStringMaker } from "utils/query";

import { Oval } from "react-loader-spinner";

const getKey = (
	perPage: number,
	query: any,
	setIsEndofData: React.Dispatch<SetStateAction<boolean>>,
	cursor: number,
	previousPageData,
) => {
	if (previousPageData && !previousPageData.length) {
		setIsEndofData(true);
		return null;
	}

	if (cursor === 0)
		return Object.keys(query).length > 0
			? `${
					process.env.END_POINT_PRODUCT
			  }/products?cursor=0&perPage=${perPage}&${queryStringMaker(query)}`
			: `${process.env.END_POINT_PRODUCT}/products?cursor=0&perPage=${perPage}`;

	return Object.keys(query).length > 0
		? `${
				process.env.END_POINT_PRODUCT
		  }/products?cursor=${cursor}&perPage=${perPage}&${queryStringMaker(query)}`
		: `${process.env.END_POINT_PRODUCT}/products?cursor=${cursor}&perPage=${perPage}`;
};

const Search: FunctionComponent = () => {
	const router = useRouter();

	const [isOpen, setIsOpen] = useState<boolean>(false);
	const [pickedProductInfo, setPickedProductInfo] = useState<ProductInfoRes>();

	const { data, error, mutate, setSize } = useSWRInfinite<ProductInfoRes[]>(
		(...args) => getKey(40, router.query, setIsEndofData, ...args),
		fetcher,
	);

	const searchProducts = data ? [].concat(...data) : [];
	const isLoadingInitialData = !data && !error;

	const [target, setTarget] = useState<HTMLElement | null | undefined>(null);
	const [isEndofData, setIsEndofData] = useState<boolean>(false);

	const onIntersect: IntersectionObserverCallback = ([entry]) => {
		if (entry.isIntersecting) {
			setSize((prev) => prev + 1);
		}
	};

	useEffect(() => {
		if (!target) return;

		const observer = new IntersectionObserver(onIntersect, {
			threshold: 0.9,
		});
		observer.observe(target);
		return () => observer && observer.disconnect();
	}, [target]);

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

	/** For Code Review
	 * onPostWish 함수 내의 mutate를 통해 찜 관련 토글을 바로 갱신합니다.
	 */
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

	if (isLoadingInitialData) {
		return (
			<NavTemplate
				headerTop={<HeaderTop />}
				headerMain={<HeaderMain />}
				footer={<Footer />}
			>
				<ShopTemplate isLoading>
					<Oval
						ariaLabel="loading-indicator"
						height={100}
						width={100}
						strokeWidth={5}
						color="black"
						secondaryColor="white"
					/>
				</ShopTemplate>
			</NavTemplate>
		);
	}

	return (
		<NavTemplate
			headerTop={<HeaderTop />}
			headerMain={<HeaderMain />}
			footer={<Footer />}
		>
			<ShopTemplate cb={setIsEndofData}>
				{searchProducts &&
					searchProducts.map((obj) => (
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
			{isEndofData ? (
				<SearchEmptyConent>
					<StatusText>더 이상 검색 결과가 없습니다.</StatusText>
				</SearchEmptyConent>
			) : (
				<ProductSkeleton />
			)}
			<div ref={setTarget} />
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

export default Search;
