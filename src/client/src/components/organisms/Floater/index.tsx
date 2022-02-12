import React, { FunctionComponent, useState } from "react";

import Button from "components/atoms/Button";
import Icon from "components/atoms/Icon";
import Knob from "components/atoms/Knob";
import ProductSmallInfo from "components/molecules/ProductSmallInfo";

import styled from "@emotion/styled";

type FloaterProps = {
	imgSrc: string;
	backgroundColor: string;
	productName: string;
	productNameKor: string;
	isWishProduct: boolean;
	wishes: number;
	productId: number;
	buyPrice: number;
	sellPrice: number;
	onClick: () => void;
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
		onClick,
	} = props;

	const onClickWish = () => {
		onClick();
	};

	return (
		<FloaterWrapper>
			<InnerBox>
				<ProductSmallInfo
					imgSrc={imgSrc}
					backgroundColor={backgroundColor}
					productName={productName}
					productNameKor={productNameKor}
				/>
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
						{isWishProduct ? (
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
