import React, { FunctionComponent, useState } from "react";

import ProductImage from "components/atoms/ProductImage";
import Icon from "components/atoms/Icon";

import styled from "@emotion/styled";

type ProductThumbnailImageProps = {
	imgSrc: string;
	backgroundColor: string;
	isInWishList: boolean;
	onHandleWishClick?: () => void;
};

const ProductThumbnailImage: FunctionComponent<ProductThumbnailImageProps> = (
	props,
) => {
	const { imgSrc, backgroundColor, isInWishList, onHandleWishClick } = props;

	const [isWish, setIsWish] = useState<boolean>(isInWishList);

	const onClick = () => {
		setIsWish(!isWish);
		onHandleWishClick();
	};

	return (
		<ProductThumbnailImageWrapper>
			{isWish ? (
				<Icon
					onClick={onClick}
					name="BookmarkFilled"
					style={{ cursor: "pointer", maxWidth: "15px", minWidth: "15px" }}
				/>
			) : (
				<Icon
					onClick={onClick}
					name="Bookmark"
					style={{ cursor: "pointer", maxWidth: "15px", minWidth: "15px" }}
				/>
			)}
			<ProductImage
				src={imgSrc}
				category="home"
				backgroundColor={backgroundColor}
			/>
		</ProductThumbnailImageWrapper>
	);
};

export default ProductThumbnailImage;

const ProductThumbnailImageWrapper = styled.div`
	position: relative;
	> svg {
		position: absolute;
		top: 20px;
		left: 20px;
		z-index: 1;
	}
	@media screen and (max-width: 770px) {
		> svg {
			position: absolute;
			top: 10px;
			left: 20px;
			z-index: 1;
		}
	}
`;
