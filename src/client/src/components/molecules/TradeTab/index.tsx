import React, { FunctionComponent, useCallback, useState } from "react";

import styled from "@emotion/styled";

type TradeTabProps = {
	category: "buy" | "sell";
	waiting: number;
	in_progress: number;
	finished: number;
	filter: string;
	onClick: React.Dispatch<React.SetStateAction<string>>;
};

const color = {
	buy: "#f15746",
	sell: "#31b46e",
};

const TradeTab: FunctionComponent<TradeTabProps> = (props) => {
	const { category, waiting, in_progress, finished, filter, onClick } = props;

	const onHandleApplyFilter = useCallback(
		(filter: string) => {
			onClick(filter);
		},
		[filter],
	);

	return (
		<TradeTabWrapper>
			<TabItem>
				{filter === "WAITING" ? (
					<StyledA activated={true}>
						<StyledDl>
							<StyledDt activated={true}>구매 입찰</StyledDt>
							<StyledDd activated={true} category={category}>
								{waiting}
							</StyledDd>
						</StyledDl>
					</StyledA>
				) : (
					<StyledA
						onClick={() => {
							onHandleApplyFilter("WAITING");
						}}
						activated={false}
					>
						<StyledDl>
							<StyledDt activated={false}>구매 입찰</StyledDt>
							<StyledDd activated={false} category={category}>
								{waiting}
							</StyledDd>
						</StyledDl>
					</StyledA>
				)}
			</TabItem>
			<TabItem>
				{filter === "IN_PROGRESS" ? (
					<StyledA activated={true}>
						<StyledDl>
							<StyledDt activated={true}>진행 중</StyledDt>
							<StyledDd activated={true} category={category}>
								{in_progress}
							</StyledDd>
						</StyledDl>
					</StyledA>
				) : (
					<StyledA
						onClick={() => {
							onHandleApplyFilter("IN_PROGRESS");
						}}
						activated={false}
					>
						<StyledDl>
							<StyledDt activated={false}>진행 중</StyledDt>
							<StyledDd activated={false} category={category}>
								{in_progress}
							</StyledDd>
						</StyledDl>
					</StyledA>
				)}
			</TabItem>
			<TabItem>
				{filter === "FINISHED" ? (
					<StyledA activated={true}>
						<StyledDl>
							<StyledDt activated={true}>종료</StyledDt>
							<StyledDd activated={true} category={category}>
								{finished}
							</StyledDd>
						</StyledDl>
					</StyledA>
				) : (
					<StyledA
						onClick={() => {
							onHandleApplyFilter("FINISHED");
						}}
						activated={false}
					>
						<StyledDl>
							<StyledDt activated={false}>종료</StyledDt>
							<StyledDd activated={false} category={category}>
								{finished}
							</StyledDd>
						</StyledDl>
					</StyledA>
				)}
			</TabItem>
		</TradeTabWrapper>
	);
};

export default TradeTab;

const TradeTabWrapper = styled.div`
	display: table;
	table-layout: fixed;
	background-color: #fff;
	border-radius: 0;
	margin-top: 20px;
	width: 100%;
	margin-bottom: 5px;
`;

const TabItem = styled.div`
	display: table-cell;
	text-align: center;
`;

const StyledA = styled.a<{ activated: boolean }>`
	padding-top: 3px;
	height: 68px;
	position: relative;
	display: block;
	border-bottom: ${({ activated }) =>
		activated ? `2px solid #222` : `1px solid #d3d3d3`};
	cursor: pointer;
`;

const StyledDl = styled.dl`
	display: flex;
	flex-direction: column-reverse;
`;

const StyledDt = styled.dt<{ activated: boolean }>`
	font-size: 13px;
	letter-spacing: -0.07px;
	color: ${({ activated }) => (activated ? `#222` : `rgba(34,34,34,.5);`)};
	font-weight: ${({ activated }) => (activated ? `700` : ``)};
`;

const StyledDd = styled.dd<{ activated: boolean; category: string }>`
	font-weight: 700;
	margin: auto;
	margin-bottom: 3px;
	font-size: 20px;
	line-height: 24px;
	letter-spacing: -0.1px;
	color: ${({ activated, category }) =>
		activated ? `${color[category]}` : `#222`};
`;
