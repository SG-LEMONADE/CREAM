import React, { FunctionComponent } from "react";
import { HomeProductInfoRes, ProductInfoRes, WishProductsRes } from "types";

import Brand from "components/atoms/Brand";
import ProductName from "components/atoms/ProductName";
import ProductNameKor from "components/atoms/ProductNameKor";

import styled from "@emotion/styled";

type ProductInfoProps = {
	category: "home" | "shop" | "product";
	productInfo: ProductInfoRes | HomeProductInfoRes | WishProductsRes;
};

const ProductInfo: FunctionComponent<ProductInfoProps> = (props) => {
	const { category, productInfo } = props;
	const { brandName, originalName } = productInfo;
	return (
		<StyledProductInfo category={category}>
			<Brand category={category}>{brandName}</Brand>
			<ProductName category={category}>{originalName}</ProductName>
			<ProductNameKor category={category}>
				{"translatedName" in productInfo && productInfo.translatedName}
			</ProductNameKor>
		</StyledProductInfo>
	);
};

export default ProductInfo;

const StyledProductInfo = styled.div<{ category: string }>`
	p:last-child {
		${({ category }) =>
			category === "product" ? `margin-top: -3px;` : `margin-top: -13px;`}
	}
`;
