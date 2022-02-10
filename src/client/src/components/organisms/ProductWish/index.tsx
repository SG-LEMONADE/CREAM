import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";
import ProductSmallInfo from "components/molecules/ProductSmallInfo";
import Knob from "components/atoms/Knob";
import Link from "next/link";

type ProductWishProps = {
	id: number;
	lowestAsk: null | number;
	imgSrc: string;
	backgroundColor: string;
	productName: string;
	size: string;
	onDeleteWish: () => void;
};

const ProductWish: FunctionComponent<ProductWishProps> = (props) => {
	const {
		id,
		lowestAsk,
		imgSrc,
		backgroundColor,
		productName,
		size,
		onDeleteWish,
	} = props;

	return (
		<ProductWishLi>
			<StyledItem>
				<Link href={`/products/${id}`} passHref>
					<a>
						<ProductSmallInfo
							imgSrc={imgSrc}
							backgroundColor={backgroundColor}
							productName={productName}
							size={size}
						/>
					</a>
				</Link>
				<ButtonWrapper>
					<Knob category="buy" productId={id} price={lowestAsk} />
					<StyledP onClick={onDeleteWish}>삭제</StyledP>
				</ButtonWrapper>
			</StyledItem>
		</ProductWishLi>
	);
};

export default ProductWish;

const ProductWishLi = styled.li`
	list-style: none;
	margin: 0;
	padding: 0;
`;

const StyledItem = styled.div`
	display: flex;
	padding: 20px 0 19px;
	align-items: center;
	border-bottom: 1px solid #ebebeb;
`;

const ButtonWrapper = styled.div`
	margin-left: auto;
	display: flex;
	flex-direction: row;
	align-items: center;
	flex-shrink: 0;
	text-align: right;
`;

const StyledP = styled.p`
	padding: 0;
	margin: 0 30px;
	display: inline-flex;
	font-size: 12px;
	letter-spacing: -0.06px;
	color: rgba(34, 34, 34, 0.8);
	text-decoration: underline;
`;

export const StyledTitle = styled.div`
	padding: 0;
	padding-bottom: 16px;
	border-bottom: 3px solid #222;
	margin: 0;
`;

export const StyledH3 = styled.h3`
	font-size: 24px;
	letter-spacing: -0.36px;
	line-height: 29px;
	margin: 0;
	padding: 0;
`;
