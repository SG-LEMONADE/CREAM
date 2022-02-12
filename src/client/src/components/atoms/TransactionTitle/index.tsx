import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";
import colors from "colors/color";

type TransactionTitleProps = {
	category: "buy" | "sell";
};

const titles = {
	buy: "구매하기",
	sell: "판매하기",
	ask: "구매 입찰하기",
	bid: "판매 입찰하기",
};

const TransactionTitle: FunctionComponent<TransactionTitleProps> = (props) => {
	const { category } = props;

	return (
		<TransactionTitleWrapper>
			<StyledH2>{titles[category]}</StyledH2>
		</TransactionTitleWrapper>
	);
};

export default TransactionTitle;

const TransactionTitleWrapper = styled.div`
	display: flex;
	padding: 0 40px 0 5px;
	height: 68px;
	min-width: 320px;
	align-items: center;
	border-bottom: 1px solid ${colors.colors.border};
	justify-content: center;
	margin-top: 100px;
`;

const StyledH2 = styled.h2`
	font-size: 1.5em;
	font-weight: bold;
`;
