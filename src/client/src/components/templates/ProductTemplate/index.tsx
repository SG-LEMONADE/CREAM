import React, {
	FunctionComponent,
	useCallback,
	useState,
	useEffect,
	useContext,
} from "react";
import { useRouter } from "next/router";
import Link from "next/link";
import axios from "axios";
import { useSWRConfig } from "swr";
import UserContext from "context/user";

import ProductInfo from "components/molecules/ProductInfo";
import SizeSelect from "components/molecules/SizeSelect";
import ProductRecentPrice from "components/molecules/ProductRecentPrice";
import Button from "components/atoms/Button";
import Knob from "components/atoms/Knob";
import ProductDetail from "components/molecules/ProductDetail";
import ProductDeliveryInfo from "components/molecules/Delivery";
import BannerImage from "components/atoms/BannerImage";
import Modal from "components/molecules/Modal";
import Slider from "components/organisms/Slider";
import ProductImage from "components/atoms/ProductImage";
import ProductSizeSelectGrid from "components/molecules/ProductSizeSelectGrid";
import Icon from "components/atoms/Icon";
import ProductThumbnail from "components/organisms/ProductThumbnail";
import Floater from "components/organisms/Floater";
import ProductSmallInfo from "components/molecules/ProductSmallInfo";
import { GraphData, ProductRes } from "types";
import { validateUser } from "lib/user";
import { getToken } from "lib/token";
import { smallImageInfos } from "utils/images";

import styled from "@emotion/styled";
import Graph from "components/organisms/Graph";

type ProductTemplateProps = {
	activatedSize: string;
	setActivatedSize: React.Dispatch<React.SetStateAction<string>>;
	productInfo: ProductRes;
	graphData?: GraphData;
};

const ProductTemplate: FunctionComponent<ProductTemplateProps> = (props) => {
	const router = useRouter();
	const { mutate } = useSWRConfig();
	const { setUser } = useContext(UserContext);

	const { activatedSize, setActivatedSize, productInfo, graphData } = props;

	const [isOpenPriceModal, setIsOpenPriceModal] = useState<boolean>(false);
	const [isOpenWishModal, setIsOpenWishModal] = useState<boolean>(false);

	const [scrolledValue, setScrolledValue] = useState<number>(0);

	const onCalculatePriceTrend = useCallback(() => {
		const value = productInfo.changeValue;
		if (value === null) return "null";
		else if (value > 0) return "increase";
		else return "decrease";
	}, []);

	const onHandleClickWish = useCallback(async () => {
		try {
			const res = await validateUser(setUser);
			if (!res) {
				router.push("/login");
			} else {
				setIsOpenWishModal(true);
			}
		} catch (e) {
			router.push("/login");
		}
	}, []);

	const onPostWish = useCallback(async (size: string) => {
		const activatedSize = router.query.size;
		const token = getToken("accessToken");

		try {
			const res = await axios.post(
				`${process.env.END_POINT_PRODUCT}/wish/${productInfo.product.id}/${size}`,
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
				mutate(
					activatedSize
						? `${process.env.END_POINT_PRODUCT}/products/${productInfo.product.id}/${activatedSize}`
						: `${process.env.END_POINT_PRODUCT}/products/${productInfo.product.id}`,
				);
			}
		} catch (err) {
			console.error(err);
		}
	}, []);

	const handleScroll = useCallback(() => {
		setScrolledValue(window.scrollY);
	}, []);

	useEffect(() => {
		window.addEventListener("scroll", handleScroll);
		return () => window.removeEventListener("scroll", handleScroll);
	});

	return (
		<ProductTemplateWrapper>
			<ProductArea>
				<ColumnBind>
					<ColumnLeft>
						<ProductSliderWrapper>
							{productInfo.product.imageUrls.length === 1 ? (
								<ProductImage
									src={productInfo.product.imageUrls[0]}
									category="product"
									backgroundColor={productInfo.product.backgroundColor}
								/>
							) : (
								<Slider
									productSlider={true}
									images={productInfo.product.imageUrls.map((url) => (
										<ProductImage
											src={url}
											category="product"
											backgroundColor={productInfo.product.backgroundColor}
										/>
									))}
								/>
							)}
						</ProductSliderWrapper>
					</ColumnLeft>
					<ColumnRight>
						<ColumnRightTop>
							<ProductTitle>
								<ProductInfo
									category="product"
									productInfo={productInfo.product}
								/>
							</ProductTitle>
							<ProductSizePriceInfos>
								<SizeSelect onClick={() => setIsOpenPriceModal(true)}>
									{productInfo.product.sizes.includes("ONE SIZE")
										? `ONE SIZE`
										: `${activatedSize}`}
								</SizeSelect>
								<ProductRecentPrice
									category={onCalculatePriceTrend()}
									amount={productInfo.changeValue}
									percentage={productInfo.changePercentage}
									price={productInfo.lastSalePrice}
								/>
							</ProductSizePriceInfos>
							<ButtonWrapper>
								<ButtonDivision>
									<Knob
										category="buy"
										productId={productInfo.product.id}
										price={productInfo.product.lowestAsk}
									/>
									<Knob
										style={{ marginLeft: "10px" }}
										category="sell"
										productId={productInfo.product.id}
										price={productInfo.product.highestBid}
									/>
								</ButtonDivision>
								<Button
									style={{ marginTop: "12px", height: "60px" }}
									category="primary"
									fullWidth
									onClick={onHandleClickWish}
								>
									{productInfo.product.wishList !== null &&
									productInfo.product.wishList.length > 0 ? (
										<Icon
											name="BookmarkFilled"
											style={{
												width: "20px",
												height: "20px",
												marginRight: "10px",
											}}
										/>
									) : (
										<Icon
											name="Bookmark"
											style={{
												width: "20px",
												height: "20px",
												marginRight: "10px",
											}}
										/>
									)}
									관심상품 {productInfo.product.wishCnt.toLocaleString()}
								</Button>
							</ButtonWrapper>
						</ColumnRightTop>
						<ColumnRightProductSpec>
							<ProductDetail
								modelNum={productInfo.product.styleCode}
								releasedAt={productInfo.product.releasedDate}
								color={productInfo.product.color}
								price={productInfo.product.originalPrice}
							/>
						</ColumnRightProductSpec>
						<ColumnRightDelivery>
							<ProductDeliveryInfo />
						</ColumnRightDelivery>
						<BannerWrapper>
							<Slider
								small
								images={smallImageInfos.map((info) => (
									<BannerImage
										bgColor={info.bgColor}
										category="small"
										moreHeight
										src={info.src}
									/>
								))}
							/>
						</BannerWrapper>
						<GraphWrapper>
							<Graph
								graphData={graphData ? graphData.total : []}
								size={activatedSize}
							/>
						</GraphWrapper>
					</ColumnRight>
				</ColumnBind>
			</ProductArea>
			<RecommendProductArea>
				<MoreTitle>
					<StyledBrand>{productInfo.product.brandName}</StyledBrand>{" "}
					<StyledText>의 다른 상품</StyledText>
					<Link href={`/search?keyword=${productInfo.product.brandName}`}>
						<MoreLink>
							더보기
							<Icon
								name="ChevronRight"
								style={{ width: "15px", height: "15px", marginLeft: "5px" }}
							/>
						</MoreLink>
					</Link>
				</MoreTitle>
				<ProductList>
					{productInfo.relatedProducts.map((product) => (
						<ProductThumbnail
							key={product.id}
							category="product"
							productInfo={product}
						/>
					))}
				</ProductList>
			</RecommendProductArea>
			<Modal
				category="else"
				onClose={() => setIsOpenPriceModal(false)}
				show={isOpenPriceModal}
				title="사이즈"
			>
				<ProductSizeSelectGrid
					category="price"
					subCategory="buy"
					datas={
						productInfo.product.sizes.includes("ONE SIZE")
							? productInfo.product.sizes
							: Object.keys(productInfo.askPrices)
					}
					pricePerSize={productInfo.askPrices}
					onClick={(size) => {
						setActivatedSize(size);
						mutate(
							`${process.env.END_POINT_PRODUCT}/products/${productInfo.product.id}/${size}`,
						);
						size !== "모든 사이즈" &&
							size !== "ONE SIZE" &&
							router.push({
								pathname: `/products/${productInfo.product.id}/`,
								query: {
									size: `${size}`,
								},
							});
						setIsOpenPriceModal(false);
					}}
					activeSizeOption={activatedSize}
				/>
			</Modal>
			<Modal
				category="wish"
				onClose={() => setIsOpenWishModal(false)}
				show={isOpenWishModal}
				title="관심 상품 추가"
			>
				<>
					<ProductSmallInfo
						imgSrc={productInfo.product.imageUrls[0]}
						backgroundColor={productInfo.product.backgroundColor}
						productName={productInfo.product.originalName}
						productNameKor={productInfo.product.translatedName}
						style={{
							borderBottom: "1px solid #eeeeee",
							paddingBottom: "10px",
							marginBottom: "10px",
						}}
					/>
					<ProductSizeSelectGrid
						category="wish"
						activeSizeOption={
							productInfo.product.wishList && productInfo.product.wishList
						}
						datas={productInfo.product.sizes}
						onClick={(size) => onPostWish(size)}
					/>
				</>
			</Modal>
			{scrolledValue > 400 && (
				<ProductSmallWrapper>
					<Floater
						imgSrc={productInfo.product.imageUrls[0]}
						backgroundColor={productInfo.product.backgroundColor}
						productName={productInfo.product.originalName}
						productNameKor={productInfo.product.translatedName}
						isWishProduct={
							productInfo.product.wishList !== null &&
							productInfo.product.wishList.length > 0
						}
						wishes={productInfo.product.wishCnt}
						productId={productInfo.product.id}
						buyPrice={productInfo.product.lowestAsk}
						sellPrice={productInfo.product.highestBid}
						onClick={onHandleClickWish}
					/>
				</ProductSmallWrapper>
			)}
		</ProductTemplateWrapper>
	);
};

export default ProductTemplate;

const ProductTemplateWrapper = styled.div`
	overflow: hidden;
	margin: 0;
	padding: 0;
	padding-top: 100px;
`;

export const ProductTemplateLoading = styled.div`
	padding: 500px 0;
	display: flex;
	justify-content: center;
`;

const ProductArea = styled.div`
	overflow: hidden;
	margin: 0 auto;
	padding: 30px 40px 120px;
	max-width: 1280px;
`;

const ColumnBind = styled.div`
	position: relative;
	margin: 0;
	padding: 0;
`;

const ColumnLeft = styled.div`
	float: left;
	padding-right: 3%;
	// position: fixed;
	// STRANGE original_ 130px
	top: 150px;
`;

const ProductSliderWrapper = styled.div``;

const ColumnRight = styled.div`
	position: relative;
	float: right;
	padding-left: 3.334%;
	width: 50%;
	&::before {
		content: "";
		display: block;
		position: absolute;
		top: 0;
		left: 0;
		bottom: 0;
		border-left: 1px solid #ebebeb;
	}
`;

const ColumnRightTop = styled.div`
	margin: 0;
	padding: 0;
`;

const ProductTitle = styled.div`
	position: relative;
`;

const ProductSizePriceInfos = styled.div`
	margin: 0;
	padding: 0;
`;

const ButtonWrapper = styled.div`
	margin: 0;
	padding: 0;
`;

const ButtonDivision = styled.div`
	margin-top: 17px;
	display: flex;
	height: 60px;
`;

const ColumnRightProductSpec = styled.div`
	margin: 0;
	padding: 0;
`;

const ColumnRightDelivery = styled.div`
	margin: 50px 0 0 0;
	padding: 0;
`;

const BannerWrapper = styled.div`
	margin: 50px 0 0 0;
`;

const GraphWrapper = styled.div`
	margin: 50px 0 0 0;
`;

const RecommendProductArea = styled.div`
	margin: 0 auto;
	padding-bottom: 40px;
	max-width: 1280px;
`;

const MoreTitle = styled.h3`
	margin: 0 40px;
	padding-top: 40px;
	display: flex;
	align-items: center;
	max-width: 100%;
	line-height: 24px;
	font-size: 20px;
	letter-spacing: -0.15px;
	border-top: 1px solid #ebebeb;
`;

const StyledBrand = styled.span`
	flex-shrink: 0;
	font-weight: 700;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
`;

const StyledText = styled.span`
	margin-right: 50px;
	flex-shrink: 0;
	font-weight: 400;
`;

const MoreLink = styled.a`
	margin-top: -2px;
	margin-left: auto;
	padding: 3px 0 3px 5px;
	display: inline-flex;
	align-items: center;
	flex-shrink: 0;
	color: rgba(34, 34, 34, 0.5);
	line-height: 20px;
	font-size: 13px;
	letter-spacing: -0.07px;
	font-weight: 400;
	cursor: pointer;
`;

const ProductList = styled.div`
	margin-top: 30px;
	padding: 0 30px;
	display: grid;
	grid-template-columns: repeat(5, 1fr);
	gap: 20px;
`;

const ProductSmallWrapper = styled.div`
	width: 100%;
	position: fixed;
	margin: auto 0;
	top: 99px;
	z-index: 100;
	background-color: white;
	padding: 10px 40px 15px;
`;
