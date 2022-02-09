import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";

type ProductNameKorProps = {
	category: string;
	children: React.ReactNode;
};

const ProductNameKor: FunctionComponent<ProductNameKorProps> = (props) => {
	const { category, children } = props;
	return (
		<StyledProductNameKor category={category}>{children}</StyledProductNameKor>
	);
};

export default ProductNameKor;

const StyledProductNameKor = styled.p<{ category: string }>`
	color: rgba(34, 34, 34, 0.5);
	overflow: hidden;
	text-overflow: ellipsis;
	display: -webkit-box;
	padding-top: ${({ category }) => category === "product" && "8px"};
	font-size: ${({ category }) => (category === "product" ? `14px` : `12px`)};
`;
