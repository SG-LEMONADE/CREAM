import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";

type PriceThumbnailProps = {
	category: string;
	price: number | null;
};

const PriceThumbnail: FunctionComponent<PriceThumbnailProps> = (props) => {
	const { category, price } = props;
	return (
		<StyledPriceWrapper category={category}>
			<StyledPrice>
				{price > 0 ? `${price.toLocaleString()}원` : `-`}
			</StyledPrice>
			<StyledDesc>즉시 구매가</StyledDesc>
		</StyledPriceWrapper>
	);
};

export default PriceThumbnail;

const StyledPriceWrapper = styled.div<{ category: string }>`
	cursor: pointer;
`;

const StyledPrice = styled.em`
	display: inline-block;
	vertical-align: top;
	line-height: 17px;
	font-size: 15px;
	font-weight: 700;
	letter-spacing: -0.04px;
	font-style: normal;
`;

const StyledDesc = styled.div`
	line-height: 13px;
	font-size: 11px;
	color: rgba(34, 34, 34, 0.5);
`;
