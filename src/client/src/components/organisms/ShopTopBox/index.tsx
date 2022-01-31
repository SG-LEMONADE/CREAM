import React, { FunctionComponent } from "react";

import QuickFilterBar from "components/molecules/QuickFilterBar";

import styled from "@emotion/styled";

type ShopTopBoxProps = {
	luxaryActivateState: boolean;
	filteredCategory: string;
	onApplyFilter: (luxary: boolean, category: string) => void;
};

const ShopTopBox: FunctionComponent<ShopTopBoxProps> = (props) => {
	const { luxaryActivateState, filteredCategory, onApplyFilter } = props;

	return (
		<SearchTop>
			<ShopTopBoxWrapper>
				<ShopTopTitle>
					<StyledH2>SHOP</StyledH2>
				</ShopTopTitle>
				<QuickFilterWrapper>
					<QuickFilterBar
						luxaryActivateState={luxaryActivateState}
						filteredCategory={filteredCategory}
						onApplyFilter={onApplyFilter}
					/>
				</QuickFilterWrapper>
			</ShopTopBoxWrapper>
		</SearchTop>
	);
};

export default ShopTopBox;

const SearchTop = styled.div`
	padding: 8px 40px 0;
	background-color: #fff;
	z-index: 100;
`;

const ShopTopBoxWrapper = styled.section`
	margin: 0 auto;
	max-width: 1200px;
`;

const ShopTopTitle = styled.div`
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 0 10% 24px;
	position: relative;
`;

const StyledH2 = styled.h2`
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	font-size: 28px;
	font-weight: 600;
	color: #000;
	letter-spacing: -0.14px;
	cursor: pointer;
`;

const QuickFilterWrapper = styled.div`
	overflow-x: auto;
	overflow-y: hidden;
	padding-bottom: 16px;
	white-space: nowrap;
`;
