import React, { CSSProperties, FunctionComponent } from "react";
import Image from "next/image";

import styled from "@emotion/styled";

type ProductImageProps = {
	backgroundColor: string;
	src: string;
	category: string;
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
			<StyledImage category={category} src={src} alt={src} />
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
