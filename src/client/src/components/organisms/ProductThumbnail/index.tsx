import React, { FunctionComponent } from "react";
import Link from "next/link";

import ProductThumbnailImage from "components/molecules/ProductThumbnailImage";
import ProductImage from "components/atoms/ProductImage";
import ProductInfo from "components/molecules/ProductInfo";
import PriceThumbnail from "components/atoms/PriceThumbnail";
import Icon from "components/atoms/Icon";

import { HomeProductInfoRes, ProductInfoRes, WishProductsRes } from "types";
import styled from "@emotion/styled";
import { css } from "@emotion/react";

type ProductThumbnailProps = {
	category: "home" | "shop" | "product";
	minWidthMode?: boolean;
	productInfo: ProductInfoRes | HomeProductInfoRes | WishProductsRes;
	isWishState?: boolean;
	onHandleWishClick?: (
		selectedProduct?: ProductInfoRes | HomeProductInfoRes,
	) => void;
};

const ProductThumbnail: FunctionComponent<ProductThumbnailProps> = (props) => {
	const {
		category,
		minWidthMode = false,
		productInfo,
		isWishState = false,
		onHandleWishClick,
	} = props;

	return (
		<ProductThumbnailWrapper minWidthMode={minWidthMode}>
			<Link href={`/products/${productInfo.id}`} passHref>
				<ProductLink>
					<ImageArea>
						{category === "home" ? (
							<ProductThumbnailImage
								imgSrc={productInfo.imageUrls[0]}
								backgroundColor={productInfo.backgroundColor}
								isInWishList={isWishState}
								onHandleWishClick={onHandleWishClick}
							/>
						) : (
							<ProductImage
								category="shop"
								src={productInfo.imageUrls[0]}
								backgroundColor={productInfo.backgroundColor}
							/>
						)}
					</ImageArea>
				</ProductLink>
			</Link>
			<InfoArea>
				<ProductInfo category={category} productInfo={productInfo} />
				<PriceThumbnail category={category} price={productInfo.lowestAsk} />
			</InfoArea>
			{category === "shop" && (
				<BookmarkArea>
					<BookmarkContents>
						<Icon
							name={isWishState ? "BookmarkFilled" : "Bookmark"}
							style={{ width: "20px", height: "20px", cursor: "pointer" }}
							onClick={onHandleWishClick}
						/>
						<BookemarkCnt selected={isWishState}>
							{"wishCnt" in productInfo && productInfo.wishCnt}
						</BookemarkCnt>
					</BookmarkContents>
				</BookmarkArea>
			)}
		</ProductThumbnailWrapper>
	);
};

export default ProductThumbnail;

const ProductThumbnailWrapper = styled.div<{ minWidthMode: boolean }>`
	clear: left;
	${({ minWidthMode }) =>
		minWidthMode &&
		css`
			min-width: 284px;
			margin-right: 30px;
		`}
`;

const ProductLink = styled.a`
	display: block;
	background-color: #fff;
	border-radius: 12px;
`;

const ImageArea = styled.div`
	margin: 0;
	padding: 0;
`;

const InfoArea = styled.div`
	padding-top: 3px;
`;

const BookmarkArea = styled.div`
	padding-top: 12px;
	margin: 0 -2px;
`;

const BookmarkContents = styled.span`
	display: inline-flex;
	align-items: center;
	vertical-align: top;
	height: 20px;
`;

const BookemarkCnt = styled.span<{ selected?: boolean }>`
	margin-left: 5px;
	font-size: 15px;
	${({ selected }) => selected && `font-weight: 700;`}
`;
