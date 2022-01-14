import React, { FunctionComponent, useState } from "react";

import ProductImage from "components/atoms/ProductImage";

import styled from "@emotion/styled";
import Icon from "components/atoms/Icon";

type ProductThumbnailProps = {
	isInWishList: boolean;
	onHandleWishClick?: () => void;
};

const ProductThumbnail: FunctionComponent<ProductThumbnailProps> = (props) => {
	const { isInWishList, onHandleWishClick } = props;

	const [isWish, setIsWish] = useState<boolean>(isInWishList);

	const onClick = () => {
		setIsWish(!isWish);
		onHandleWishClick();
	};

	return (
		<ProductThumbnailWrapper>
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
				src="https://kream-phinf.pstatic.net/MjAyMTExMTZfMzkg/MDAxNjM3MDQzMzM0MzUz.94K4SoFB9IWLnLRh2iUXjWN0s53ADBEfhwIQQVC_kbAg.4Xl3LXELbnhDdMl8Vz0RdUF7JdQzk_LYyhOHIDvIQUgg.PNG/a_d38d4d9403c34c7c9f4f52bf2ce4f649.png?type=m"
				category="shop"
				backgroundColor="rgb(246, 238, 237)"
			/>
		</ProductThumbnailWrapper>
	);
};

export default ProductThumbnail;

const ProductThumbnailWrapper = styled.div`
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
