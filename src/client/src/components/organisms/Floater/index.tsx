import React, { FunctionComponent, useState } from "react";
import Image from "next/image";

import Button from "components/atoms/Button";
import Icon from "components/atoms/Icon";
import Knob from "components/atoms/Knob";

import styled from "@emotion/styled";

type FloaterProps = {
	imgSrc: string;
	backgroundColor: string;
	productName: string;
	productNameKor: string;
	isWishProduct: boolean;
	wishes: number;
	productId: string;
	buyPrice: number;
	sellPrice: number;
};

const Floater: FunctionComponent<FloaterProps> = (props) => {
	const {
		imgSrc,
		backgroundColor,
		productName,
		productNameKor,
		isWishProduct,
		wishes,
		productId,
		buyPrice,
		sellPrice,
	} = props;

	const [isWished, setIsWished] = useState<boolean>(isWishProduct);

	const onClickWish = () => {
		setIsWished(!isWished);
		// FIX ME - api call will be added.
	};

	return (
		<FloaterWrapper>
			<InnerBox>
				<ProductArea>
					<ProductThumb backgroundColor={backgroundColor}>
						<StyledImg src={imgSrc} />
					</ProductThumb>
					<ProductInfoArea>
						<StyledProductName>{productName}</StyledProductName>
						<StyledProductNameKor>{productNameKor}</StyledProductNameKor>
					</ProductInfoArea>
				</ProductArea>
				<ButtonArea>
					<Button
						style={{
							width: "160px",
							height: "50px",
							display: "flex",
							justifyContent: "space-evenly",
							alignItems: "center",
						}}
						category="primary"
						onClick={onClickWish}
					>
						{isWished ? (
							<Icon
								style={{ width: "20px", height: "20px" }}
								name="BookmarkFilled"
							/>
						) : (
							<Icon style={{ width: "20px", height: "20px" }} name="Bookmark" />
						)}

						{wishes.toLocaleString()}
					</Button>
					<TransactionBtnArea>
						<Knob
							style={{ height: "50px", width: "180px" }}
							category="buy"
							price={buyPrice}
							productId={productId}
						/>
						<Knob
							style={{ height: "50px", width: "180px" }}
							category="sell"
							price={sellPrice}
							productId={productId}
						/>
					</TransactionBtnArea>
				</ButtonArea>
			</InnerBox>
		</FloaterWrapper>
	);
};

export default Floater;

const FloaterWrapper = styled.div`
	display: block;
	width: 100%;
`;

const InnerBox = styled.div`
	display: flex;
	align-items: center;
	justify-content: space-between;
`;

const ProductArea = styled.div`
	padding-right: 40px;
	display: flex;
`;

const ProductThumb = styled.div<{ backgroundColor: string }>`
	background-color: ${({ backgroundColor }) => backgroundColor};
	flex: none;
	margin-right: 12px;
	width: 64px;
	height: 64px;
	border-radius: 12px;
`;

const StyledImg = styled(Image)`
	width: 100%;
	vertical-align: top;
`;

const ProductInfoArea = styled.div`
	display: flex;
	flex-direction: column;
	justify-content: center;
	flex: 1;
`;

const StyledProductName = styled.p`
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	line-height: 18px;
	font-size: 15px;
	margin: 10px 0 0 0;
`;

const StyledProductNameKor = styled.p`
	line-height: 14px;
	font-size: 12px;
	letter-spacing: -0.06px;
	color: rgba(34, 34, 34, 0.5);
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
`;

const ButtonArea = styled.div`
	display: flex;
	align-items: center;
	width: 560px;
	height: 50px;
	* {
		margin-left: 8px;
	}
`;

const TransactionBtnArea = styled.div`
	flex: 1;
	width: 100%;
	margin-top: 0;
`;
