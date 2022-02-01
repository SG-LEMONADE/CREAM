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
		<ImageWrapper category={category} backgroundColor={backgroundColor}>
			<StyledImage
				width="100"
				height="100"
				category={category}
				src={src}
				alt={src}
			/>
		</ImageWrapper>
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

const StyledImage = styled(Image)<{ category: string }>`
	width: ${({ category }) =>
		category === "products"
			? `${imageSizes[category]}px`
			: `${imageSizes[category]}%`};
	height: auto;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
`;
