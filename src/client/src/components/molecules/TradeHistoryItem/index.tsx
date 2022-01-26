import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";
import ProductSmallInfo from "../ProductSmallInfo";

type TradeHistoryItemProps = {
	imgSrc: string;
	backgroundColor: string;
	productName: string;
	size: string;
	status?: number;
	wishedPrice?: number;
	expiredDate?: string;
};

const TradeHistoryItem: FunctionComponent<TradeHistoryItemProps> = (props) => {
	const {
		imgSrc,
		backgroundColor,
		productName,
		size,
		status = -1,
		wishedPrice,
		expiredDate,
	} = props;

	const StatusCode = {
		0: "입찰 중",
		1: "진행 중",
		2: "종료",
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
				{status >= 0 && (
					<StatusBlock>
						<StautsText>{StatusCode[status]}</StautsText>
					</StatusBlock>
				)}
				{wishedPrice && (
					<StatusBlock>
						<StautsText>{wishedPrice.toLocaleString()}원</StautsText>
					</StatusBlock>
				)}
				{expiredDate && (
					<StatusBlock>
						<StautsText>{`${expiredDate.slice(0, 4)} / ${expiredDate.slice(
							4,
							6,
						)} / ${expiredDate.slice(6)}`}</StautsText>
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
}
`;

const StautsText = styled.span`
	display: block;
	font-size: 14px;
	letter-spacing: -0.21px;
`;
