import React, { FunctionComponent, useState } from "react";

import styled from "@emotion/styled";
import ProductSmallInfo from "components/molecules/ProductSmallInfo";
import PriceInfo from "components/molecules/PriceInfo";
import PriceTab from "components/molecules/PriceTab";
import PriceInput from "components/molecules/PriceInput";
import DeadLine from "components/molecules/DeadLine";
import Button from "components/atoms/Button";

type TransactionTemplateProps = {
	category: "buy" | "sell";
	auction?: boolean;
	imgSrc: string;
	backgroundColor: string;
	styledCode: string;
	originalName: string;
	translatedName: string;
	selectedSize: string;
	askPricePerSize: any;
	bidPricePerSize: any;
	instantPrice?: null | number;
	onHandleTrade: (
		cate: string,
		auction: boolean,
		date: number,
		price: number,
	) => void;
};

const TransactionTemplate: FunctionComponent<TransactionTemplateProps> = (
	props,
) => {
	const {
		category,
		auction,
		imgSrc,
		backgroundColor,
		styledCode,
		originalName,
		translatedName,
		selectedSize,
		askPricePerSize,
		bidPricePerSize,
		instantPrice,
		onHandleTrade,
	} = props;

	const [isAuction, setIsAuction] = useState<boolean>(auction);
	const [userInputPrice, setUserInputPrice] = useState<number>(
		instantPrice === null ? 0 : instantPrice,
	);
	const [validationDate, setValidationDate] = useState<number>(0);

	const onHandleCheckUserInput = () => {
		if (
			isAuction &&
			category === "buy" &&
			askPricePerSize[selectedSize] !== null &&
			askPricePerSize[selectedSize] <= userInputPrice
		) {
			setIsAuction(!isAuction);
			setUserInputPrice(askPricePerSize[selectedSize]);
		}
		if (
			isAuction &&
			category === "sell" &&
			bidPricePerSize[selectedSize] !== null &&
			bidPricePerSize[selectedSize] >= userInputPrice
		) {
			setIsAuction(!isAuction);
			setUserInputPrice(bidPricePerSize[selectedSize]);
		}
	};

	const onHandleClickTradeBtn = () => {
		console.log(category, "거래를 할 것이고, ");
		console.log("가격은 ", userInputPrice);
		console.log(isAuction ? `경매 이며,` : `경매가 아니며,`);
		console.log("입찰 마감 기한은, ", validationDate);
		onHandleTrade(category, isAuction, validationDate, userInputPrice);
	};

	return (
		<TransactionTemplateWrapper>
			<TransactionContentsWrapper>
				<TransactionContents>
					<ProductSmallWrapper>
						<ProductSmallInfo
							big
							imgSrc={imgSrc}
							backgroundColor={backgroundColor}
							styleCode={styledCode}
							productName={originalName}
							productNameKor={translatedName}
							style={{
								paddingBottom: "10px",
								marginBottom: "10px",
							}}
							size={selectedSize}
						/>
					</ProductSmallWrapper>
					<PricesWrapper>
						<PriceInfo
							askPrice={askPricePerSize[selectedSize]}
							bidPrice={bidPricePerSize[selectedSize]}
						/>
						<PriceTab
							category={category}
							auction={isAuction}
							blocked={
								category === "buy"
									? askPricePerSize[selectedSize] === null
									: bidPricePerSize[selectedSize] === null
							}
							setUserInputPrice={setUserInputPrice}
							onClick={(auctionState) => setIsAuction(auctionState)}
							instantAsk={askPricePerSize[selectedSize] !== null}
							instantAskPrice={askPricePerSize[selectedSize]}
							instantBid={bidPricePerSize[selectedSize] !== null}
							instantBidPrice={bidPricePerSize[selectedSize]}
						/>
						<PriceInput
							category={category}
							auction={isAuction}
							onChange={setUserInputPrice}
							instantMode={!isAuction}
							instantDealValue={
								category === "buy"
									? askPricePerSize[selectedSize]
									: bidPricePerSize[selectedSize]
							}
							onHandleBlur={onHandleCheckUserInput}
						/>
					</PricesWrapper>
					{isAuction && <DeadLine setDueDate={setValidationDate} />}
					<ButtonWrapper>
						<TotalPriceWrapper>
							<StyledDl>
								<StyledDt>총 정산금액</StyledDt>
								<StyledDd category={category}>
									<StyledSpan>
										{userInputPrice === 0
											? `0`
											: category === "sell"
											? `${userInputPrice}`
											: `${userInputPrice + 5000}`}
									</StyledSpan>
									<StyledSpanNonItalic>원</StyledSpanNonItalic>
								</StyledDd>
							</StyledDl>
						</TotalPriceWrapper>
						<Button
							disabled={userInputPrice === 0}
							fullWidth
							category="primary"
							onClick={onHandleClickTradeBtn}
						>
							{category === "buy"
								? `${!isAuction ? `즉시` : ``} 구매 ${
										isAuction ? `입찰` : ``
								  } 계속`
								: `${!isAuction ? `즉시` : ``} 판매 ${
										isAuction ? `입찰` : ``
								  } 계속`}
						</Button>
					</ButtonWrapper>
				</TransactionContents>
			</TransactionContentsWrapper>
		</TransactionTemplateWrapper>
	);
};

export default TransactionTemplate;

const TransactionTemplateWrapper = styled.div`
	background-color: #fafafa;
`;

const TransactionContentsWrapper = styled.div`
	margin: 0 auto;
	padding: 20px 40px 160px;
	max-width: 780px;
`;

const TransactionContents = styled.div`
	background-color: #fff;
`;

const ProductSmallWrapper = styled.div`
	padding: 32px 32px 0px 32px;
`;

const PricesWrapper = styled.div`
	padding: 0 32px 32px;
`;

const ButtonWrapper = styled.div`
	padding: 0 32px 32px;
	border-top: 1px solid #ebebeb;
	background-color: #fff;
`;

const TotalPriceWrapper = styled.div`
	padding-top: 16px;
	padding-bottom: 12px;
`;

const StyledDl = styled.dl`
	display: flex;
	justify-content: space-between;
	align-items: center;
`;

const StyledDt = styled.dt`
	font-size: 15px;
	font-weight: 700;
	letter-spacing: -0.01px;
`;

const StyledDd = styled.dd<{ category: string }>`
	color: ${({ category }) => (category === "buy" ? `#ef6253` : `#41b979`)};
`;

const StyledSpan = styled.span`
	line-height: 26px;
	font-style: italic;
	font-size: 20px;
	font-weight: 600;
	letter-spacing: normal;
`;

const StyledSpanNonItalic = styled.span`
	line-height: 26px;
	font-size: 20px;
	letter-spacing: -0.3px;
	font-weight: 700;
	letter-spacing: -0.15px;
	margin-left: 5px;
`;
