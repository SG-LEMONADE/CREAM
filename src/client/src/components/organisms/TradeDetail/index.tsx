import React, { FunctionComponent } from "react";

import { TradeHistoryItemRes } from "types";
import TradeTab from "components/molecules/TradeTab";
import TradeHistoryItem from "components/molecules/TradeHistoryItem";

import styled from "@emotion/styled";

type TradeDetailProps = {
	category: "buy" | "sell";
	waiting: number;
	in_progress: number;
	finished: number;
	filter: string;
	onClick: React.Dispatch<React.SetStateAction<string>>;
	items: TradeHistoryItemRes[];
};

const TradeDetail: FunctionComponent<TradeDetailProps> = (props) => {
	const { category, waiting, in_progress, finished, items, filter, onClick } =
		props;

	return (
		<TradeDetailWrapper>
			<TradeTab
				category={category}
				waiting={waiting}
				in_progress={in_progress}
				finished={finished}
				filter={filter}
				onClick={onClick}
			/>
			{items.length > 0 ? (
				items.map((item) => (
					<TradeHistoryItem
						key={item.imageUrl[0]}
						imgSrc={item.imageUrl[0]}
						backgroundColor={item.backgroundColor}
						productName={item.name}
						size={item.size}
						// FIX ME
						// wishedPrice={item.}
						expiredDate={item.validationDate}
					/>
				))
			) : (
				<TradeDetailEmptySection>
					<StyledP>거래 내역이 없습니다.</StyledP>
				</TradeDetailEmptySection>
			)}
		</TradeDetailWrapper>
	);
};

export default TradeDetail;

const TradeDetailWrapper = styled.section``;

export const StyledH3 = styled.h3`
	line-height: 29px;
	font-size: 24px;
	letter-spacing: -0.36px;
`;

const TradeDetailEmptySection = styled.div`
	padding: 80px 0;
	text-align: center;
`;

const StyledP = styled.p`
	font-size: 13px;
	letter-spacing: -0.07px;
	color: rgba(34, 34, 34, 0.5);
`;
