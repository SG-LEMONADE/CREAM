import React, { CSSProperties, FunctionComponent } from "react";
import Image from "next/image";

import styled from "@emotion/styled";
import { css } from "@emotion/react";

type ProductImageProps = {
	backgroundColor: string;
	src: string;
	category: "home" | "shop" | "products";
	style?: CSSProperties;
};

const imageSizes = {
	home: "81.5",
	shop: "81.5",
	products: "560",
};

const ProductImage: FunctionComponent<ProductImageProps> = (props) => {
	const { backgroundColor, category, src } = props;
	return (
		<TmpWrapper category={category} backgroundColor={backgroundColor}>
			<StyledImg
				src={src}
				alt={src}
				width="230"
				height="230"
				category={category}
			/>
		</TmpWrapper>
	);
};

export default ProductImage;

const ImageWrapper = styled.div<{ category: string; backgroundColor: string }>`
	background-color: ${({ backgroundColor }) => backgroundColor};
	border-radius: 8px;
	position: relative;
	width: ${({ category }) => (category === "products" ? `560px` : `25%`)};
	padding-top: ${({ category }) => (category === "products" ? `560px` : `25%`)};
	overflow: hidden;
	${({ category }) =>
		category !== "products" &&
		css`
			max-width: ${category === "home" ? `282px` : `230px`};
			padding-top: ${category === "home"
				? `min(282px, 25%)`
				: `min(230px, 20%)`};
		`}
`;

const TmpWrapper = styled.div<{ category: string; backgroundColor: string }>`
	background-color: ${({ backgroundColor }) => backgroundColor};
	border-radius: 8px;
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
	width: ${({ category }) => category === "products" && `560px`};
	${({ category }) =>
		category !== "products" &&
		css`
			max-width: ${category === "home" ? `282px` : `230px`};
		`}
`;

const StyledImg = styled(Image)<{ category: string }>`
	border-radius: 8px;
	top: 0;
	width: ${({ category }) =>
		category === "products"
			? `${imageSizes[category]}px`
			: `${imageSizes[category]}%`};
	height: auto;
`;
