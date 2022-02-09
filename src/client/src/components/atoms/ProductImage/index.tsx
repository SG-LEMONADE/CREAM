import React, { CSSProperties, FunctionComponent } from "react";
import Image from "next/image";

import styled from "@emotion/styled";
import { css } from "@emotion/react";

type ProductImageProps = {
	backgroundColor: string;
	src: string;
	category: "home" | "shop" | "product";
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
			<StyledImg
				src={src}
				alt={src}
				width={category === "product" ? `500` : `230`}
				height={category === "product" ? `500` : `230`}
				category={category}
			/>
		</ImageWrapper>
	);
};

export default ProductImage;

const ImageWrapper = styled.div<{ category: string; backgroundColor: string }>`
	background-color: ${({ backgroundColor }) => backgroundColor};
	border-radius: 8px;
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
	width: ${({ category }) => category === "product" && `560px`};
	height: ${({ category }) => category === "product" && `560px`};
	${({ category }) =>
		category !== "product" &&
		css`
			max-width: ${category === "home" ? `282px` : `230px`};
		`}
`;

const StyledImg = styled(Image)<{ category: string }>`
	border-radius: 8px;
	top: 0;
	width: ${({ category }) =>
		category === "product"
			? `${imageSizes[category]}px`
			: `${imageSizes[category]}%`};
	height: auto;
`;
