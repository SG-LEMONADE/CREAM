import React, { FunctionComponent } from "react";
import Link from "next/link";

import styled from "@emotion/styled";
import { css } from "@emotion/react";

type BrandProps = {
	category: "home" | "products" | "shop";
	children: React.ReactNode;
	productId?: string;
};

const Brand: FunctionComponent<BrandProps> = (props) => {
	const { category, children } = props;

	return category !== "shop" ? (
		<Link href={`/search?keyword=${children}`} passHref>
			<StyledA category={category}>{children}</StyledA>
		</Link>
	) : (
		<StyledBrand category={category}>{children}</StyledBrand>
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

const StyledA = styled.a<{ category: string }>`
	margin-top: 14px;
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
