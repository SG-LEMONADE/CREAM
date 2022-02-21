import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";
import ProductSmallInfo from "../ProductSmallInfo";
import Icon from "components/atoms/Icon";

type TradeHistoryItemProps = {
	id?: number;
	imgSrc: string;
	backgroundColor: string;
	productName: string;
	size: string;
	price?: number;
	status?: string;
	wishedPrice?: number;
	expiredDate?: string;
	onDelete?: (id: number) => void;
};

const TradeHistoryItem: FunctionComponent<TradeHistoryItemProps> = (props) => {
	const {
		id,
		imgSrc,
		backgroundColor,
		productName,
		size,
		status,
		price,
		expiredDate,
		onDelete,
	} = props;

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
				{!expiredDate && status && (
					<StatusBlock>
						<StautsText>{StatusCode[status]}</StautsText>
					</StatusBlock>
				)}
				{price && (
					<ProductPriceBlock>{price.toLocaleString()}원</ProductPriceBlock>
				)}
				{expiredDate && (
					<StatusBlock>
						<StautsText>{expiredDate.slice(0, 10)}</StautsText>
					</StatusBlock>
				)}
				{expiredDate && status === "WAITING" && (
					<Icon
						name="Trash"
						style={{
							width: "17px",
							height: "17px",
							marginLeft: "65px",
							cursor: "pointer",
						}}
						onClick={() => onDelete(id)}
					></Icon>
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

const ProductPriceBlock = styled.div`
	display: block;
	font-size: 14px;
	/* margin-right: auto; */
	margin-right: 4rem;
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
