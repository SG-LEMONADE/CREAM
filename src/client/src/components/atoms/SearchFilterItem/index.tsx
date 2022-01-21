import React, { FunctionComponent, useEffect, useState } from "react";

import Icon from "../Icon";

import styled from "@emotion/styled";
import CheckBox from "../Checkbox";

type SearchFilterItemProps = {};

const SearchFilterItem: FunctionComponent<SearchFilterItemProps> = (props) => {
	const {} = props;

	const [isOpen, setIsOpen] = useState<boolean>(true);
	const [activatedOptions, setActivateOption] = useState<string[]>([]);

	useEffect(() => {
		console.log("rerendered!");
	});

	return (
		<StyledWrapper>
			<FilterTitleArea onClick={() => setIsOpen(!isOpen)}>
				<FilterText>
					<MainTitle>브랜드</MainTitle>
					<SubTitle>모든 브랜드</SubTitle>
				</FilterText>
				{isOpen ? (
					<Icon
						name="Minus"
						style={{ width: "20px", color: "rgba(34,34,34,0.5)" }}
					/>
				) : (
					<Icon
						name="Plus"
						style={{ width: "20px", color: "rgba(34,34,34,0.5)" }}
					/>
				)}
			</FilterTitleArea>
			<FilterActiveContentsArea isOpen={isOpen}>
				<StyledUl>
					<StyledLi onClick={() => console.log("!")}>
						<StyledA>
							<CheckBox>APC</CheckBox>
						</StyledA>
					</StyledLi>
					<StyledLi>
						<StyledA>
							<CheckBox>Acne Studios</CheckBox>
						</StyledA>
					</StyledLi>
					<StyledLi>
						<StyledA>
							<CheckBox>Alexander MacQueen</CheckBox>
						</StyledA>
					</StyledLi>
				</StyledUl>
			</FilterActiveContentsArea>
		</StyledWrapper>
	);
};

export default SearchFilterItem;

const StyledWrapper = styled.div`
	border-bottom: 1px solid #ebebeb;
`;

const FilterTitleArea = styled.div`
	display: flex;
	padding: 16px 0;
	justify-content: space-between;
	align-items: center;
	cursor: pointer;
`;

const FilterText = styled.div`
	flex-direction: column;
	max-width: calc(100% - 30px);
`;

const MainTitle = styled.div`
	position: relative;
	font-size: 13px;
	letter-spacing: -0.07px;
	font-weight: 600;
`;

const SubTitle = styled.div`
    margin-top: 4px;
    overflow: hidden
    text-overflow: ellipsis;
    white-space: nowrap;
    font-size: 15px;
    letter-spacing: -.15px;
    color: rgba(34,34,34,0.5)
`;

const FilterActiveContentsArea = styled.div<{ isOpen: boolean }>`
	padding-bottom: 24px;
	${({ isOpen }) => (isOpen ? `` : `display: none;`)}
`;

const StyledUl = styled.ul`
	margin: 0;
	padding: 0;
	max-height: 315px;
	overflow-y: auto;
	list-style: none;
`;

const StyledLi = styled.li`
	margin: 0;
	padding: 0;
	list-style: none;
	padding-bottom: 5px;
`;

const StyledA = styled.a`
	display: flex;
	align-items: flex-start;
	font-size: 14px;
	letter-spacing: -0.21px;
`;

const StyledSpan = styled.span`
	max-width: 160px;
`;
