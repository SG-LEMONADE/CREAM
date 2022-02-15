import React, { FunctionComponent, SetStateAction } from "react";

import styled from "@emotion/styled";

type PriceTabProps = {
	category: "buy" | "sell";
	auction: boolean;
	blocked?: boolean;
	setUserInputPrice: React.Dispatch<SetStateAction<number>>;
	onClick: (auctionState: boolean) => void;
	instantAsk: boolean;
	instantAskPrice: null | number;
	instantBid: boolean;
	instantBidPrice: null | number;
};

const PriceTab: FunctionComponent<PriceTabProps> = (props) => {
	const {
		category,
		auction,
		blocked = false,
		setUserInputPrice,
		onClick,
		instantAsk,
		instantAskPrice,
		instantBid,
		instantBidPrice,
	} = props;

	return (
		<PriceTabWrapper>
			<TabButtonWrapper>
				<StyledUl>
					<StyledLeftLi
						onClick={() => {
							onClick(true);
							setUserInputPrice(0);
						}}
					>
						{auction ? (
							<StyledTab category={category}>
								{category === "buy" ? `구매` : "판매"} 입찰
							</StyledTab>
						) : (
							<StyledPNormal blocked={blocked}>
								{category === "buy" ? `구매` : "판매"} 입찰
							</StyledPNormal>
						)}
					</StyledLeftLi>
					<StyledRightLi
						onClick={() => {
							if (category === "buy" && instantAsk) {
								onClick(false);
								setUserInputPrice(instantAskPrice);
							} else if (category === "sell" && instantBid) {
								onClick(false);
								setUserInputPrice(instantBidPrice);
							}
						}}
					>
						{auction ? (
							<StyledPNormal blocked={blocked}>
								즉시 {category === "buy" ? `구매` : "판매"}
							</StyledPNormal>
						) : (
							<StyledTab category={category}>
								즉시 {category === "buy" ? `구매` : "판매"}
							</StyledTab>
						)}
					</StyledRightLi>
				</StyledUl>
			</TabButtonWrapper>
		</PriceTabWrapper>
	);
};

export default PriceTab;

const PriceTabWrapper = styled.div`
	margin: 0;
	padding: 0;
	position: relative;
`;

const TabButtonWrapper = styled.div`
	position: 0;
	margin: 0;
	padding: 0;
`;

const StyledUl = styled.ul`
	margin: 0;
	padding: 0;
	border-radius: 80px;
	border: 1px solid #ebebeb;
	margin-bottom: 27px;
	list-style: none;
	display: flex;
	background-color: #f4f4f4;
	flex-direction: row;
`;

const StyledLeftLi = styled.li`
	margin: 4px 0;
	margin-left: 4px;
	list-style: none;
	width: 50vw;
`;

const StyledRightLi = styled.li`
	margin: 4px 0;
	margin-right: 4px;
	list-style: none;
	width: 50vw;
`;

const StyledTab = styled.a<{ category: string }>`
	border-radius: 80px;
	padding: 14px 0;
	font-size: 14px;
	letter-spacing: 0.15px;
	display: block;
	text-align: center;
	line-height: 16px;
	background-color: ${({ category }) =>
		category === "buy" ? `#ef6253` : `#41b979`};
	color: #fff;
	font-weight: 700;
	cursor: pointer;
`;

const StyledPNormal = styled.a<{ blocked: boolean }>`
	border-radius: 80px;
	padding: 14px 0;
	font-size: 14px;
	letter-spacing: 0.15px;
	display: block;
	text-align: center;
	line-height: 16px;
	color: rgba(34, 34, 34, 0.8);
	${({ blocked }) => !blocked && `cursor: pointer`}
`;
