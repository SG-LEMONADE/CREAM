import React, { FunctionComponent, useEffect, useRef } from "react";

import Chart from "chart.js/auto";
import styled from "@emotion/styled";

type GraphProps = {
	children?: React.ReactNode;
	graphData: { date: string; price: number }[];
	size?: string;
};

const Graph: FunctionComponent<GraphProps> = (props) => {
	const { graphData, size } = props;

	const canvasDom = useRef(null);

	useEffect(() => {
		const ctx = canvasDom.current.getContext("2d");

		let delayed;

		graphData.length > 0 &&
			new Chart(ctx, {
				type: "line",
				data: {
					labels: graphData.map((data) => data.date),
					datasets: [
						{
							label: "기간별 구매가",
							fill: false,
							backgroundColor: "white",
							borderColor: "black",
							borderCapStyle: "butt",
							borderDash: [],
							borderDashOffset: 0.0,
							borderJoinStyle: "bevel",
							pointBorderColor: "black",
							pointBackgroundColor: "#fff",
							pointBorderWidth: 3,
							pointHoverRadius: 20,
							pointHoverBackgroundColor: "black",
							pointHoverBorderColor: "rgba(220,220,220,1)",
							pointHoverBorderWidth: 10,
							pointRadius: 4,
							pointHitRadius: 10,
							data: graphData.map((data) => data.price),
						},
					],
				},
				options: {
					animation: {
						onComplete: () => {
							delayed = true;
						},
						delay: (context) => {
							let delay = 0;
							if (!delayed) {
								delay = context.dataIndex * 400 + context.datasetIndex * 100;
							}
							return delay;
						},
					},
					animations: {
						tension: {
							duration: 1000,
							easing: "easeInCubic",
							from: 0,
							to: 0.5,
							loop: true,
						},
					},
					interaction: {
						intersect: false,
						mode: "index",
					},

					plugins: {},
					scales: {
						y: {
							min:
								Math.min.apply(
									Math,
									graphData.map((data) => data.price),
								) - 10000,
							max:
								Math.max.apply(
									Math,
									graphData.map((data) => data.price),
								) + 10000,
						},
					},
				},
			});
	}, []);

	return (
		<GraphWrapper>
			<TitleArea>
				<Title>시세</Title>
				<Size>{size ? size : `모든 사이즈`}</Size>
			</TitleArea>
			<canvas ref={canvasDom}></canvas>
			{graphData.length === 0 && (
				<EmptyWrapper>
					<EmptyData>
						<StyledP>아직 거래 내역이 없어요. 😢</StyledP>
					</EmptyData>
				</EmptyWrapper>
			)}
		</GraphWrapper>
	);
};

export default React.memo(Graph);

const GraphWrapper = styled.div`
	position: relative;
	max-width: 1000px;
`;

const TitleArea = styled.div`
	display: flex;
`;

const Title = styled.h3`
	margin: 0;
	padding: 0;
	line-height: 22px;
	padding: 39px 0 20px;
	font-size: 18px;
	letter-spacing: -0.15px;
`;

const Size = styled.div`
	position: relative;
	margin-left: auto;
	padding: 40px 0 20px;
	font-size: 16px;
	font-weight: 600;
	margin-right: 5%;
`;

const EmptyWrapper = styled.div`
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: hsla(0, 0%, 100%, 0.8);
`;

const EmptyData = styled.div`
	position: absolute;
	top: 35%;
	left: 23%;
	width: 320px;
	height: 150px;
	text-align: center;
	background-color: #fff;
	border: 1px solid #d3d3d3;
`;

const StyledP = styled.p`
	margin: 0;
	padding: 0;
	padding-top: 60px;
	font-size: 14px;
	letter-spacing: -0.21px;
`;
