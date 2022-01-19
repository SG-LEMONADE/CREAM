import React, { CSSProperties, FunctionComponent } from "react";

import styled from "@emotion/styled";

type KnobProps = {
	category: "buy" | "sell";
	productId: string;
	price: number;
	style?: CSSProperties;
};

const Knob: FunctionComponent<KnobProps> = (props) => {
	const { category, price, productId, style } = props;
	return (
		<StyledKnobWrapper
			href={`/${category}/select/${productId}?size=`}
			category={category}
			style={style}
		>
			<Divider />
			<StyledCategory>{category === "buy" ? `구매` : `판매`}</StyledCategory>
			<StyledPriceWrapper>
				<StyledSpan>
					<StyledPrice>{price.toLocaleString()}원</StyledPrice>
					<StyledDesc>즉시판매가</StyledDesc>
				</StyledSpan>
			</StyledPriceWrapper>
		</StyledKnobWrapper>
	);
};

export default Knob;

const StyledKnobWrapper = styled.a<{ category: string }>`
	position: relative;
	//STRANGE display: flex;
	display: inline-flex;
	flex: 1;
	align-items: center;
	border-radius: 10px;
	color: #fff;
	cursor: pointer;
	background-color: ${({ category }) =>
		category === "buy" ? "#ef6153" : "#41b979"};
	text-decoration: none;
	height: 60px;
	min-width: 150px;
`;

const Divider = styled.div`
	content: "";
	position: absolute;
	top: 0;
	bottom: 0;
	left: 55px;
	width: 1px;
	background-color: rgba(34, 34, 34, 0.1);
`;

const StyledCategory = styled.strong`
	width: 55px;
	text-align: center;
	font-size: 18px;
	letter-spacing: -0.27px;
	font-wieght: bold;
`;

const StyledPriceWrapper = styled.div`
	margin-left: 10px;
	line-height: 15px;
`;

const StyledSpan = styled.span`
	display: block;
	font-size: 0;
	line-height: 15px;
`;

const StyledPrice = styled.em`
	display: inline-block;
	font-style: normal;
	font-size: 15px;
	vertical-align: top;
	line-height: 15px;
	font-weight: 700;
`;

const StyledDesc = styled.span`
    display: block;
    font-size: 11px;
    font-weight: 600;
    color: hsla(0,0%,100%,.8);
}
`;
