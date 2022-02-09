import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";
import Icon from "components/atoms/Icon";

type ProductRecentPriceProps = {
	category: "increase" | "decrease" | "null";
	amount: number;
	percentage: number;
	price: number;
};

const ProductRecentPrice: FunctionComponent<ProductRecentPriceProps> = (
	props,
) => {
	const { category, amount, percentage, price } = props;
	return (
		<ProductRecentPriceWrapper>
			<StyledTitle>
				<StyledSpan>최근 거래가</StyledSpan>
			</StyledTitle>
			<StyledPriceArea>
				{category !== "null" ? (
					<>
						<StyledPrice>{price.toLocaleString()}원</StyledPrice>
						<StyledPriceVariation category={category}>
							{category === "increase" ? (
								<Icon
									name="CaretUp"
									style={{
										width: "15px",
										height: "15px",
										marginRight: "5px",
										color: "f15746",
									}}
								/>
							) : (
								<Icon
									name="CaretDown"
									style={{
										width: "15px",
										height: "15px",
										marginRight: "5px",
										color: "31b46e",
									}}
								/>
							)}
							{amount.toLocaleString()}원
							{category === "increase"
								? `(+${percentage}%)`
								: `(-${percentage}%)`}
						</StyledPriceVariation>
					</>
				) : (
					<>
						<StyledPrice>-</StyledPrice>
						<div style={{ fontSize: "13px" }}>-</div>
					</>
				)}
			</StyledPriceArea>
		</ProductRecentPriceWrapper>
	);
};

export default ProductRecentPrice;

const ProductRecentPriceWrapper = styled.div`
	margin-top: 11px;
	min-height: 44px;
	display: flex;
	justify-content: space-between;
`;

const StyledTitle = styled.div``;

const StyledSpan = styled.span`
	padding-top: 5px;
	display: inline-block;
	font-size: 13px;
	letter-spacing: -0.07px;
	color: rgba(34, 34, 34, 0.8);
`;

const StyledPriceArea = styled.div`
	float: right;
	padding-top: 2px;
	text-align: right;
	font-size: 18px;
`;

const StyledPrice = styled.div`
    line-height: 26px;
    font-weight: 700;
    font-size: 0'
`;

const StyledPriceVariation = styled.div<{ category: string }>`
	font-size: 13px;
	color: ${({ category }) => (category === "increase" ? "#f15746" : "#31b46e")};
`;
