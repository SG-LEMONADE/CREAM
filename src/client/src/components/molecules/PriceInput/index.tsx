import React, { FunctionComponent, useState } from "react";

import styled from "@emotion/styled";
import { css } from "@emotion/react";

type PriceInputProps = {
	category: "buy" | "sell";
	auction?: boolean;
	onChange?: React.Dispatch<React.SetStateAction<number>>;
	instantMode: boolean;
	instantDealValue?: null | number;
	onHandleBlur: () => void;
};

const title = {
	buy: "구매",
	sell: "판매",
};

const PriceInput: FunctionComponent<PriceInputProps> = (props) => {
	const {
		category,
		auction = false,
		onChange,
		instantMode,
		instantDealValue,
		onHandleBlur,
	} = props;

	const [isFocus, setIsFocus] = useState<boolean>(false);
	const [isError, setIsError] = useState<boolean>(false);

	const onHandleChangeInput = (e: React.ChangeEvent<HTMLInputElement>) => {
		const inputValue = e.target.value;
		setIsError(!/^\d+$/.test(inputValue));
		onChange?.(parseInt(e.target.value));
	};

	return (
		<>
			<PriceInputWrapper>
				<StyledDl isFocus={isFocus} isError={isError}>
					<StyledDt isError={isError}>
						{auction
							? `${title[category]} 희망가`
							: `즉시 ${title[category]}가`}
					</StyledDt>
					<StyledDd>
						{instantMode ? (
							<StyledSpanInput>
								{instantDealValue && instantDealValue.toLocaleString()}
							</StyledSpanInput>
						) : (
							<StyledInput
								onChange={onHandleChangeInput}
								onFocus={() => setIsFocus(true)}
								onBlur={() => {
									setIsFocus(false);
									onHandleBlur();
								}}
								placeholder="희망가 입력"
							/>
						)}
						<StyledSpan>원</StyledSpan>
					</StyledDd>
				</StyledDl>
				{isError && (
					<ErrorMsg>
						<p style={{ margin: 0, padding: 0 }}>
							3만원 부터 천원단위로 <strong>숫자만</strong> 입력하세요.
						</p>
					</ErrorMsg>
				)}
			</PriceInputWrapper>
			<ExtraPrice>
				{auction && (
					<ExternalDl>
						<ExternalDt>검수비</ExternalDt>
						<ExternalDd>무료</ExternalDd>
					</ExternalDl>
				)}
				{category === "sell" && (
					<ExternalDl>
						<ExternalDt>판매 수수료</ExternalDt>
						<ExternalDd>무료</ExternalDd>
					</ExternalDl>
				)}
				<ExternalDl>
					<ExternalDt>배송비</ExternalDt>
					<ExternalDd>
						{category === "buy" ? `5000원` : `선불 · 판매자 부담`}
					</ExternalDd>
				</ExternalDl>
			</ExtraPrice>
		</>
	);
};

export default PriceInput;

const PriceInputWrapper = styled.div`
	position: relative;
	margin: 0;
	padding: 0;
`;

const StyledDl = styled.dl<{ isFocus: boolean; isError: boolean }>`
	margin: 0;
	padding: 0;
	display: flex;
	justify-content: space-between;
	padding-bottom: 10px;
	border-bottom: ${({ isFocus }) =>
		isFocus ? `2px solid #222` : `2px solid #ebebeb`};
	${({ isError }) =>
		isError &&
		css`
			border-bottom: 2px solid #ef6253;
		`}
`;

const StyledDt = styled.dt<{ isError: boolean }>`
	font-size: 14px;
	letter-spacing: -0.21px;
	font-weight: 700;
	min-width: 63px;
	height: 40px;
	${({ isError }) => isError && `color: #ef6253`}
`;

const StyledDd = styled.dd`
	display: flex;
	align-items: center;
	margin: 0;
	padding: 0;
	margin-top: 15px;
`;

const StyledInput = styled.input`
	font-size: 20px;
	font-style: normal;
	line-height: 26px;
	font-weight: 600;
	text-align: right;
	letter-spacing: normal;
	max-width: 200px;
	box-sizing: border-box;
	border-width: 0;
	overflow: visible;
	outline: 0;
	font-style: italic;
	::placeholder {
		color: #bcbcbc;
		font-style: normal;
	}
	:disabled {
		background-color: #fff;
	}
`;

const StyledSpanInput = styled.span`
	line-height: 26px;
	font-style: italic;
	font-size: 20px;
	letter-spacing: -0.1px;
	font-weight: 600;
	letter-spacing: normal;
`;

const StyledSpan = styled.span`
	padding-left: 2px;
	line-height: 26px;
	font-size: 20px;
	letter-spacing: -0.3px;
	font-weight: 700;
	margin-left: 10px;
`;

const ErrorMsg = styled.div`
	font-size: 13px;
	color: #f15746;
	position: absolute;
	display: block;
	top: 0;
	right: 0;
	margin: 0;
	padding: 0;
`;

const ExtraPrice = styled.div`
	margin: 0;
	padding: 0;
	padding-top: 10px;
	font-size: 13px;
	letter-spacing: -0.07px;
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
