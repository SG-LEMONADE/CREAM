import React, { FunctionComponent } from "react";
import Link from "next/link";

import CollectionTitle from "components/atoms/CollectionTitle";
import Icon from "components/atoms/Icon";
import TradeSummary from "components/molecules/TradeSummary";
import TradeHistoryItem from "components/molecules/TradeHistoryItem";
import { TradeHistoryItemRes } from "types";

import styled from "@emotion/styled";

type TradeHistoryProps = {
	category: "buy" | "sell";
	total: number;
	waiting: number;
	pending: number;
	over: number;
	items: TradeHistoryItemRes[];
};

const TradeHistory: FunctionComponent<TradeHistoryProps> = (props) => {
	const { category, total, waiting, pending, over, items } = props;

	return (
		<TradeHistoryWrapper>
			<TradeHistoryTitle>
				<CollectionTitle
					title={category === "buy" ? `구매 내역` : `판매 내역`}
				/>
				<Link href={category === "buy" ? `/my/buying` : `/my/selling`} passHref>
					<StyledA>
						<StyledSpan>더보기</StyledSpan>
						<Icon
							name="ChevronRight"
							style={{
								width: "15px",
								height: "15px",
								color: "rgba(34, 34, 34, 0.5)",
							}}
						/>
					</StyledA>
				</Link>
			</TradeHistoryTitle>
			<RecentTrade>
				<TradeSummary
					category={category}
					total={total}
					waiting={waiting}
					pending={pending}
					over={over}
				/>
				{items.length > 0 ? (
					items.map((item) => (
						<Link href={`/products/${item.productId}`} passHref>
							<a>
								<TradeHistoryItem
									key={`${item.name}/${item.imageUrl[0]}/${item.validationDate}/${item.size}`}
									imgSrc={item.imageUrl[0]}
									backgroundColor={item.backgroundColor}
									productName={item.name}
									size={item.size}
									status={item.tradeStatus}
								/>
							</a>
						</Link>
					))
				) : (
					<TradeHistoryEmptySection>
						<StyledP>거래 내역이 없습니다.</StyledP>
					</TradeHistoryEmptySection>
				)}
			</RecentTrade>
		</TradeHistoryWrapper>
	);
};

export default TradeHistory;

const TradeHistoryWrapper = styled.section`
	margin-top: 60px;
	padding-bottom: 30px;
`;

const TradeHistoryTitle = styled.div`
	margin-top: 42px;
	padding-bottom: 16px;
	display: flex;
	max-width: 100%;
`;

const StyledA = styled.a`
	margin-top: 3px;
	margin-left: auto;
	padding-top: 3px;
	padding-left: 5px;
	display: inline-flex;
	flex-shrink: 0;
`;

const StyledSpan = styled.span`
	font-size: 13px;
	letter-spacing: -0.07px;
	color: rgba(34, 34, 34, 0.5);
	padding-right: 10px;
`;

const RecentTrade = styled.div`
	margin: 0;
	padding: 0;
`;

const TradeHistoryEmptySection = styled.div`
	padding: 80px 0;
	text-align: center;
`;

const StyledP = styled.p`
	font-size: 13px;
	letter-spacing: -0.07px;
	color: rgba(34, 34, 34, 0.5);
`;
