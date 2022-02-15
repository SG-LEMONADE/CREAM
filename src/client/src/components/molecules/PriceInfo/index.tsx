import React, { FunctionComponent } from "react";

import styled from "@emotion/styled";

type PriceInfoProps = {
	askPrice: null | number;
	bidPrice: null | number;
};

const PriceInfo: FunctionComponent<PriceInfoProps> = (props) => {
	const { askPrice, bidPrice } = props;

	return (
		<PriceInfoWrapper>
			<PriceInfoLi>
				<Category>즉시 구매가</Category>
				<StyledSpan>
					{askPrice === null ? `-` : `${askPrice.toLocaleString()}원`}
				</StyledSpan>
			</PriceInfoLi>
			<PriceInfoLi>
				<Category>즉시 판매가</Category>
				<StyledSpan>
					{bidPrice === null ? `-` : `${bidPrice.toLocaleString()}원`}
				</StyledSpan>
			</PriceInfoLi>
		</PriceInfoWrapper>
	);
};

export default PriceInfo;

const PriceInfoWrapper = styled.ul`
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 28px 0px 22px 0px;
	border-top: 1px solid #ebebeb;
`;

const PriceInfoLi = styled.li`
	flex: 1;
	text-align: center;
	list-style: none;
	margin: 0;
	padding: 0;
	&::before {
		content: "";
		position: absolute;
		left: 50%;
		width: 1px;
		height: 70px;
		background-color: #ebebeb;
	}
`;

const Category = styled.p`
	margin: 0 0 10px 0;
	line-height: 14px;
	font-size: 12px;
	letter-spacing: -0.06px;
	color: rgba(34, 34, 34, 0.5);
`;

const StyledSpan = styled.span`
	display: inline-block;
	line-height: 24px;
	vertical-align: top;
	font-size: 16px;
`;
