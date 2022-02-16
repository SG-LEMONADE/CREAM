import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";
import ProductSmallInfo from "../ProductSmallInfo";

type TradeHistoryItemProps = {
	imgSrc: string;
	backgroundColor: string;
	productName: string;
	size: string;
	status?: string;
	wishedPrice?: number;
	expiredDate?: string;
};

const TradeHistoryItem: FunctionComponent<TradeHistoryItemProps> = (props) => {
	const { imgSrc, backgroundColor, productName, size, status, expiredDate } =
		props;

	const StatusCode = {
		WAITING: "입찰 중",
		IN_PROGRESS: "진행 중",
		COMPLETED: "종료",
	};

	return (
		<TradeHistoryItemItemWrapper>
			<HistoryProductArea>
				<ProductSmallInfo
					imgSrc={imgSrc}
					backgroundColor={backgroundColor}
					productName={productName}
					size={size}
				/>
			</HistoryProductArea>
			<HistoryStatusArea>
				{status && (
					<StatusBlock>
						<StautsText>{StatusCode[status]}</StautsText>
					</StatusBlock>
				)}
				{expiredDate && (
					<StatusBlock>
						<StautsText>{expiredDate.slice(0, 10)}</StautsText>
					</StatusBlock>
				)}
			</HistoryStatusArea>
		</TradeHistoryItemItemWrapper>
	);
};

export default TradeHistoryItem;

const TradeHistoryItemItemWrapper = styled.div`
	border-bottom: 1px solid #ebebeb;
	padding: 12px;
	display: flex;
	align-items: center;
`;

const HistoryProductArea = styled.div`
	display: flex;
	cursor: pointer;
	max-width: 80%;
`;

const HistoryStatusArea = styled.div`
	margin-left: auto;
	display: flex;
	align-items: center;
	text-align: right;
`;

const StatusBlock = styled.div`
	display: block;
	margin-left: 25px;
	// width: 134px;
`;

const StautsText = styled.span`
	display: block;
	font-size: 14px;
	letter-spacing: -0.21px;
`;
