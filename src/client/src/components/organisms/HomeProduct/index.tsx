import React, { FunctionComponent, useEffect, useState } from "react";

import BannerImage from "components/atoms/BannerImage";
import CollectionTitle from "components/atoms/CollectionTitle";
import Button from "components/atoms/Button";
import ProductThumbnail from "components/organisms/ProductThumbnail";
import { HomeProductInfoRes } from "types";

import styled from "@emotion/styled";

type HomeProductProps = {
	imageUrl: string;
	bgColor: string;
	header: string;
	detail: string;
	productInfo: HomeProductInfoRes[];
	onHandleWishClick: (selectedProduct?: HomeProductInfoRes) => void;
};

const HomeProduct: FunctionComponent<HomeProductProps> = (props) => {
	const { imageUrl, bgColor, header, detail, productInfo, onHandleWishClick } =
		props;

	const [viewProducts, setViewProducts] = useState<HomeProductInfoRes[]>([]);
	const [viewIndex, setViewIndex] = useState<number>(0);
	const [isEndProduct, setIsEndProduct] = useState<boolean>(false);

	const onHandleMore = () => {
		if (productInfo.length > (viewIndex + 2) * 4) {
			setViewProducts(productInfo.slice(0, (viewIndex + 2) * 4));
			setViewIndex(viewIndex + 1);
		} else {
			setViewProducts(productInfo.slice(0, (viewIndex + 2) * 4));
			setIsEndProduct(true);
		}
	};

	useEffect(() => {
		if (productInfo.length > 4) {
			setViewProducts(productInfo.slice(viewIndex, viewIndex + 4));
		} else {
			setViewProducts(productInfo.slice(viewIndex));
			setIsEndProduct(true);
		}
	}, [productInfo]);

	return (
		<HomeProductWrapper>
			<BannerImage category="big" src={imageUrl} bgColor={bgColor} />
			<ProductArea>
				<TitleArea>
					<CollectionTitle title={header} subTitle={detail} />
				</TitleArea>
				<ProductsArea>
					<ProductImageArea>
						{viewProducts.map((product) => (
							<ProductThumbnail
								key={product.id}
								category="home"
								productInfo={product}
								isWishState={
									product.wishList !== null
										? product.wishList.length > 0
										: false
								}
								onHandleWishClick={() => {
									onHandleWishClick(product);
								}}
							/>
						))}
					</ProductImageArea>
					<ButtonArea>
						{isEndProduct ? (
							<Button category="primary" disabled>
								더보기
							</Button>
						) : (
							<Button category="primary" onClick={onHandleMore}>
								더보기
							</Button>
						)}
					</ButtonArea>
				</ProductsArea>
			</ProductArea>
		</HomeProductWrapper>
	);
};

export default HomeProduct;

const HomeProductWrapper = styled.section`
	margin: 100px 0;
`;

const ProductArea = styled.div`
	margin-top: 30px;
	@media screen and (max-width: 1400px) {
		padding: 0 40px;
	}
`;

const ProductsArea = styled.div`
	max-width: 1280px;
	margin: 0 auto;
	overflow-anchor: none;
`;

const TitleArea = styled.div`
	max-width: 1280px;
	margin: 0 auto;
`;

const ProductImageArea = styled.div`
	overflow: hidden;
	position: relative;
	margin: 20px auto;
	width: 100%;
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	gap: 50px 10px;
`;

const ButtonArea = styled.div`
	margin-top: 60px;
	text-align: center;
`;
