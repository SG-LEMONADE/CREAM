import React, { FunctionComponent } from "react";
import styled from "@emotion/styled";
import Link from "next/link";
import { css } from "@emotion/react";

type BrandProps = {
	category: string;
	children: React.ReactNode;
	productId?: string;
};

const Brand: FunctionComponent<BrandProps> = (props) => {
	const { category, children, productId } = props;
	const hrefLink = productId
		? `/products/${productId}`
		: `/search?keyword=${children}`;
	return (
		<Link href={hrefLink}>
			<StyledBrand category={category}>{children}</StyledBrand>
		</Link>
	);
};

export default Brand;

const StyledBrand = styled.p<{ category: string }>`
	overflow: hidden;
	display: inline-block;
	// STRANGE
	margin-bottom: -5px;
	vertical-align: top;
	height: 17px;
	line-height: 17px;
	font-size: 16px;
	font-weight: 700;
	color: #333;
	white-space: nowrap;
	text-overflow: ellipsis;
	border-bottom: ${({ category }) =>
		category === "home" ? `1px solid #222` : ``};
	${({ category }) =>
		category === "product" &&
		css`
			border-bottom: 2px solid #222;
			line-height: 19px;
			font-size: 18px;
			font-weight: 800;
		`}
`;
