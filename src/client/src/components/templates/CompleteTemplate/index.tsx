import React, { FunctionComponent, useEffect, useState } from "react";
import { useRouter } from "next/router";

import styled from "@emotion/styled";
import Image from "next/image";
import Button from "components/atoms/Button";

type CompleteTemplateProps = {
	category: "buy" | "sell";
	auction: boolean;
	imageUrl: string;
	backgroundColor: string;
	price: number;
	date?: number;
};

const titles = {
	buy: "구매",
	sell: "판매",
};

const CompleteTemplate: FunctionComponent<CompleteTemplateProps> = (props) => {
	const router = useRouter();

	const {
		category,
		auction,
		imageUrl,
		backgroundColor,
		price,
		date = 0,
	} = props;

	const [validDate, setValidDate] = useState<string>("");

	useEffect(() => {
		let result = new Date();
		result.setDate(result.getDate() + date);
		setValidDate(result.toISOString().slice(0, 10));
	}, [date]);

	return (
		<CompleteTemplateWrapper>
			<CompleteContentsWrapper>
				<CompleteContents>
					<ImageWrapper backgroundColor={backgroundColor}>
						<Image src={imageUrl} width="200" height="200" />
					</ImageWrapper>
					<CompleteDetailWrapper>
						<CompleteInfo>
							<CompleteTitleArea>
								<CompleteTitle>
									{auction
										? `${titles[category]} 입찰이 완료되었습니다.`
										: `즉시 ${titles[category]}가 완료되었습니다.`}
								</CompleteTitle>
								{auction ? (
									<>
										<CompleteSubTitle>
											결제는 거래가 성사되는 시점에{" "}
										</CompleteSubTitle>
										<CompleteSubTitle>
											{" "}
											결제 정보로 자동 처리 됩니다.
										</CompleteSubTitle>
									</>
								) : (
									<CompleteSubTitle>
										주문일 기준 3~5일 이내 받아보실 수 있습니다.
									</CompleteSubTitle>
								)}
							</CompleteTitleArea>
							<CompleteButtonWrapper>
								<Button
									category="primary"
									onClick={() => router.push(`/my/${category}ing`)}
								>
									내역 상세 보기
								</Button>
								<Button
									category="primary"
									onClick={() => router.push("/search")}
								>
									SHOP 가기
								</Button>
							</CompleteButtonWrapper>
							<CompleteExtraP>
								‘구매내역 &gt; 입찰 중’ 상태일 때는 입찰 지우기가 가능합니다.
							</CompleteExtraP>
						</CompleteInfo>
						<CompletePriceWrapper>
							<TotalPrice>
								<StyledDl>
									<PriceTitle>총 결제금액</PriceTitle>
									<FinalPrice category={category}>
										<StyledSpan italic>
											{category === "buy"
												? `${(price + 5000).toLocaleString()}`
												: `${price.toLocaleString()}`}
										</StyledSpan>
										<StyledSpan italic={false}>원</StyledSpan>
									</FinalPrice>
								</StyledDl>
							</TotalPrice>
							<PriceExtraWrapper>
								<OriginalPriceWrapper>
									<dt>
										{category === "buy" ? "구매" : "판매"}
										{auction ? ` 희망가` : `가`}
									</dt>
									<OriginalPrice>{price.toLocaleString()} 원</OriginalPrice>
								</OriginalPriceWrapper>
								<ExternalDl>
									<ExternalDt>검수비</ExternalDt>
									<ExternalDd>무료</ExternalDd>
								</ExternalDl>
								<ExternalDl>
									<ExternalDt>배송비</ExternalDt>
									<ExternalDd>
										{category === "buy" ? "5000원" : "선불 · 판매자 부담 "}
									</ExternalDd>
								</ExternalDl>
							</PriceExtraWrapper>
							{auction && (
								<ValidDateWrapper>
									<OriginalPriceWrapper>
										<dt>입찰 마감 기한</dt>
										<OriginalPrice>
											{date}일 / {validDate}까지
										</OriginalPrice>
									</OriginalPriceWrapper>
								</ValidDateWrapper>
							)}
						</CompletePriceWrapper>
					</CompleteDetailWrapper>
				</CompleteContents>
			</CompleteContentsWrapper>
		</CompleteTemplateWrapper>
	);
};

export default CompleteTemplate;

const CompleteTemplateWrapper = styled.div`
	background-color: #fafafa;
	margin-top: 100px;
`;

const CompleteContentsWrapper = styled.div`
	margin: 0 auto;
	padding: 20px 40px 160px;
	max-width: 780px;
`;

const CompleteContents = styled.div`
	background-color: #fff;
	margin: 0 auto;
	width: 440px;
	box-shadow: 4px 0 10px 0 rgb(0 0 0 / 10%);
`;

const ImageWrapper = styled.div<{ backgroundColor: string }>`
	position: relative;
	border-radius: 0;
	padding-top: 0;
	height: 200px;
	text-align: center;
	background-color: ${({ backgroundColor }) => backgroundColor};
`;

const CompleteDetailWrapper = styled.div`
	margin: 0;
	padding: 0;
`;

const CompleteInfo = styled.div`
	padding: 31px 32px;
	text-align: center;
`;

const CompleteTitleArea = styled.div`
	margin: 0;
	padding: 0;
`;

const CompleteTitle = styled.p`
	margin: 0;
	padding: 0;
	line-height: 36px;
	font-size: 20px;
	letter-spacing: -0.3px;
	font-weight: 700;
	letter-spacing: -0.15px;
`;

const CompleteSubTitle = styled.p`
	margin: 0;
	padding: 0;
	line-height: 17px;
	margin-top: 3px;
	font-size: 14px;
	letter-spacing: -0.21px;
	color: rgba(34, 34, 34, 0.8);
`;

const CompleteButtonWrapper = styled.div`
	display: flex;
	margin-top: 21px;
	justify-content: center;
	font-size: 0;
	& :first-child {
		margin-right: 10px;
	}
`;

const CompleteExtraP = styled.p`
	margin: 0;
	padding: 0;
	padding-top: 8px;
	letter-spacing: -0.07px;
	font-size: 13px;
	color: rgba(34, 34, 34, 0.5);
`;

const CompletePriceWrapper = styled.div`
	padding: 21px 32px 32px;
`;

const TotalPrice = styled.div`
	padding-bottom: 14px;
	border-width: 1px;
	padding-top: 0;
	border-top: 0;
	padding-bottom: 19px;
	border-bottom: 2px solid #ebebeb;
`;

const StyledDl = styled.dl`
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin: 0;
	padding: 0;
`;

const PriceTitle = styled.dt`
	line-height: 18px;
	font-size: 15px;
	letter-spacing: -0.15px;
	color: #222;
	font-weight: 700;
`;

const FinalPrice = styled.dd<{ category: string }>`
	display: flex;
	align-items: center;
	color: ${({ category }) => (category === "buy" ? `#f15746` : `#31b46e`)};
`;

const StyledSpan = styled.span<{ italic: boolean }>`
	line-height: 26px;
	font-style: ${({ italic }) => (italic ? `italic` : `normal`)};
	font-size: 20px;
	font-weight: 600;
	letter-spacing: normal;
	margin-right: ${({ italic }) => italic && "10px"};
`;

const PriceExtraWrapper = styled.div`
	padding-top: 11px;
	font-size: 13px;
	letter-spacing: -0.07px;
`;

const OriginalPriceWrapper = styled.dl`
	display: flex;
	justify-content: space-between;
	align-items: center;
	min-height: 26px;
	font-size: 13px;
	letter-spacing: -0.07px;
	margin: 0;
	padding: 0;
`;

const OriginalPrice = styled.dd`
	text-align: right;
	white-space: nowrap;
	color: #222;
	font-size: 14px;
	letter-spacing: -0.21px;
	font-weight: 700;
`;

const ExternalDl = styled.dl`
	margin: 0;
	padding: 0;
	margin-top: 0;
	display: flex;
	justify-content: space-between;
	align-items: center;
	min-height: 26px;
	font-size: 13px;
	letter-spacing: -0.07px;
`;

const ExternalDt = styled.dt`
	margin: 0;
	padding: 0;
	color: rgba(34, 34, 34, 0.5);
`;

const ExternalDd = styled.dd`
	margin: 0;
	padding: 0;
	text-align: right;
	white-space: nowrap;
	color: #222;
	font-size: 14px;
	letter-spacing: -0.21px;
`;

const ValidDateWrapper = styled.div`
	padding-top: 10px;
	border-top: 1px solid #ebebeb;
	font-size: 13px;
	letter-spacing: -0.07px;
`;
