import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";
import Link from "next/link";

type TradeSummaryProps = {
	category?: "buy" | "sell";
	total: number;
	waiting: number;
	pending: number;
	over: number;
};

const TradeSummary: FunctionComponent<TradeSummaryProps> = (props) => {
	const { category, total, waiting, pending, over } = props;

	return (
		<TradeSummaryWrapper>
			<TabItem>
				<Link href={`my/buying`}>
					<StyledA>
						<StyledDl>
							<StyledDt>전체</StyledDt>
							<StyledDdColored category={category}>{total}</StyledDdColored>
						</StyledDl>
					</StyledA>
				</Link>
			</TabItem>
			<TabItem>
				<Link href={`my/buying`}>
					<StyledA>
						<StyledDl>
							<StyledDt>입찰 중</StyledDt>
							<StyledDd>{waiting}</StyledDd>
						</StyledDl>
					</StyledA>
				</Link>
			</TabItem>
			<TabItem>
				<Link href={`my/buying`}>
					<StyledA>
						<StyledDl>
							<StyledDt>진행 중</StyledDt>
							<StyledDd>{pending}</StyledDd>
						</StyledDl>
					</StyledA>
				</Link>
			</TabItem>
			<TabItem>
				<Link href={`my/buying`}>
					<StyledA>
						<StyledDl>
							<StyledDt>종료</StyledDt>
							<StyledDd>{over}</StyledDd>
						</StyledDl>
					</StyledA>
				</Link>
			</TabItem>
		</TradeSummaryWrapper>
	);
};

export default TradeSummary;

const TradeSummaryWrapper = styled.div`
	display: table;
	table-layout: fixed;
	width: 100%;
	background-color: #fafafa;
	border-radius: 12px;
	margin: 0;
	padding: 0;
`;

const TabItem = styled.div`
	display: table-cell;
	text-align: center;
`;

const StyledA = styled.a`
	position: relative;
	display: block;
	padding-top: 18px;
	height: 96px;
	&: before {
		content: "";
		position: absolute;
		top: 18px;
		right: 0;
		width: 1px;
		bottom: 18px;
		background-color: #ebebeb;
	}
	&:before last-child {
		display: none;
	}
`;

const StyledDl = styled.dl`
	margin: 0;
	padding: 0;
`;

const StyledDt = styled.dt`
	font-size: 13px;
	letter-spacing: -0.07px;
	color: rgba(34, 34, 34, 0.8);
`;

const StyledDdColored = styled.dd<{ category: string }>`
	font-size: 18px;
	line-height: 20px;
	letter-spacing: -0.09px;
	font-weight: 700;
	margin: 2px 0 auto;
	color: ${({ category }) => (category === "buy" ? `#f15746` : `#31b46e`)};
`;

const StyledDd = styled.dd`
	margin: 2px 0 auto;
	font-size: 18px;
	line-height: 20px;
	letter-spacing: -0.09px;
	font-weight: 700;
`;
