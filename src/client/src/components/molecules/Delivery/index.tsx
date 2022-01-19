import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";
import Image from "next/image";

const ProductDeliveryInfo: FunctionComponent = () => {
	return (
		<>
			<ProductDeliveryInfoWrapper>
				<ProductDeliveryTitle>
					<strong>CREAM</strong> 배송은 이러합니다! 😤
				</ProductDeliveryTitle>
				<ProductDeliveryWay>
					<WayInfo>
						<WayImg>
							<Image
								width="40px"
								height="40px"
								src="https://kream-phinf.pstatic.net/MjAyMTExMjFfMjU5/MDAxNjM3NDczNzU0MjA1.ON3pvFYAq_xSSaNWDgUWe1YfIx-C0fm91PDtcsUn3AEg.Q4EbbNWl_ua916jg0NQ0dWOS3h7W9eiiI2kK9YPWlgwg.PNG/a_120a84f036724d0d97a2343aafff4ecf.png"
							/>
						</WayImg>
						<WayDesc>
							<WaySubtitle>
								<BadgeTitle>후다닥 배송 | </BadgeTitle>
								<span>5,000원 ⚡️</span>
							</WaySubtitle>
							<WayLast>
								지금 결제시&nbsp;
								<em style={{ color: "#297dcb", fontStyle: "normal" }}>
									내일 모레 새벽 도착 🥳
								</em>
							</WayLast>
						</WayDesc>
					</WayInfo>
				</ProductDeliveryWay>
			</ProductDeliveryInfoWrapper>
			<ProductDeliveryInfoWrapper>
				<ProductDeliveryWay>
					<WayInfo>
						<WayImg>
							<Image
								width="40px"
								height="40px"
								src="https://kream-phinf.pstatic.net/MjAyMTExMjlfMTQ4/MDAxNjM4MTc4MjI5NTk3.2phJLPtRvFqViNfhZu06HzNRiUBlT4cmZR4_Ukqsyesg.ikrfWOrL7WXCVO0Rqy5kMvOn3B2YpjLUj6RuJqosPX0g.PNG/a_8b54cbca40e945f4abf1ee24bdd031f7.png"
							/>
						</WayImg>
						<WayDesc>
							<WaySubtitle>
								<BadgeTitle>안전한 배송 | </BadgeTitle>
								<span> 🚚</span>
							</WaySubtitle>
							<WayLast>정확 신속한 검수 후 배송드려요! 😉</WayLast>
						</WayDesc>
					</WayInfo>
				</ProductDeliveryWay>
			</ProductDeliveryInfoWrapper>
		</>
	);
};

export default ProductDeliveryInfo;

const ProductDeliveryInfoWrapper = styled.div`
	margin: 0;
	padding: 0;
`;

const ProductDeliveryTitle = styled.h3`
	line-height: 17px;
	padding-bottom: 0;
	font-size: 14px;
	letter-spacing: -0.21px;
	font-weight: 400;
	color: rgba(34, 34, 34, 0.8);
`;

const ProductDeliveryWay = styled.div``;

const WayInfo = styled.div`
	display: flex;
	align-items: center;
	width: 100%;
	border-bottom: 1px solid #f0f0f0;
`;

const WayImg = styled.div`
	height: 40px;
	width: 40px;
	margin-right: 14px;
`;

const WayDesc = styled.div`
	flex: 1;
`;

const WaySubtitle = styled.p`
	font-size: 14px;
	letter-spacing: -0.21px;
	line-height: 17px;
`;

const BadgeTitle = styled.span`
	font-weight: 600;
`;

const WayLast = styled.p`
	line-height: 16px;
	margin-top: -10px;
	font-size: 14px;
	color: rgba(34, 34, 34, 0.5);
`;
