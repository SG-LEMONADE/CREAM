import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";
import { css } from "@emotion/react";

type ProductNameProps = {
	category: string;
	children: React.ReactNode;
};

const ProductName: FunctionComponent<ProductNameProps> = (props) => {
	const { category, children } = props;
	return <StyledProductName category={category}>{children}</StyledProductName>;
};

export default ProductName;

const StyledProductName = styled.p<{ category: string }>`
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: normal;
	height: auto;
	line-height: ${({ category }) => (category === "home" ? `17px` : `16px`)}
	font-size: ${({ category }) => (category === "home" ? `14px` : `13px`)};
	color: #222;
	${({ category }) =>
		category === "product" &&
		css`
			margin-bottom: 4px;
			font-size: 16px;
			letter-spacing: -0.09px;
			font-weight: 400;
		`}
`;
