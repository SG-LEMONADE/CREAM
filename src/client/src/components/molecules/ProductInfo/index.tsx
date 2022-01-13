import React, { FunctionComponent } from "react";
import { ProductInfoRes } from "types";

import Brand from "components/atoms/Brand";
import ProductName from "components/atoms/ProductName";
import ProductNameKor from "components/atoms/ProductNameKor";

import styled from "@emotion/styled";

type ProductInfoProps = {
	category: string;
	children: React.ReactNode;
	productInfo: ProductInfoRes;
};

const ProductInfo: FunctionComponent<ProductInfoProps> = (props) => {
	const { category, productInfo } = props;
	const { brandName, name, translatedName } = productInfo;
	return (
		<StyledProductInfo category={category}>
			<Brand category={category}>{brandName}</Brand>
			<ProductName category={category}>{name}</ProductName>
			<ProductNameKor category={category}>{translatedName}</ProductNameKor>
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
