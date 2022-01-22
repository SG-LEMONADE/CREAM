import React, { FunctionComponent, useEffect, useState } from "react";

import Icon from "../Icon";
import CheckBox from "../Checkbox";

import styled from "@emotion/styled";
import { css } from "@emotion/react";

type SearchFilterItemProps = {
	onlyOneChecked?: boolean;
	title: string;
	optionsList: string[];
};

const SearchFilterItem: FunctionComponent<SearchFilterItemProps> = (props) => {
	const { onlyOneChecked = false, title, optionsList } = props;

	const [isOpen, setIsOpen] = useState<boolean>(false);
	const [activatedOptions, setActivateOption] = useState<string[]>([]);

	const onToggleFilter = (e: React.SyntheticEvent<HTMLLabelElement>) => {
		const target = e.currentTarget.dataset.content;

		if (activatedOptions.includes(target))
			setActivateOption(activatedOptions.filter((option) => option !== target));
		else setActivateOption([...activatedOptions, target]);
	};

	const onToggleCategoryFilter = (
		e: React.SyntheticEvent<HTMLLabelElement>,
	) => {
		const target = e.currentTarget.dataset.content;
		if (activatedOptions.includes(target)) setActivateOption([]);
		else setActivateOption([target]);
	};

	useEffect(() => {
		console.log(activatedOptions);
	}, [activatedOptions]);

	return (
		<StyledWrapper>
			<FilterTitleArea onClick={() => setIsOpen(!isOpen)}>
				<FilterText>
					{activatedOptions.length > 0 ? (
						<MainTitle active>{title}</MainTitle>
					) : (
						<MainTitle active={false}>{title}</MainTitle>
					)}
					{activatedOptions.length > 0 ? (
						<SubTitleActive>{activatedOptions.join(", ")}</SubTitleActive>
					) : (
						<SubTitle>모든 브랜드</SubTitle>
					)}
				</FilterText>
				{isOpen ? (
					<Icon
						name="Minus"
						style={{
							width: "20px",
							color: "rgba(34,34,34,0.5)",
							display: "inline-block",
						}}
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
					{optionsList.map((option) => (
						<StyledLi key={option}>
							<StyledA>
								<CheckBox
									defaultChecked={activatedOptions.includes(option)}
									onClick={
										onlyOneChecked ? onToggleCategoryFilter : onToggleFilter
									}
								>
									{option}
								</CheckBox>
							</StyledA>
						</StyledLi>
					))}
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

const MainTitle = styled.div<{ active: boolean }>`
	position: relative;
	font-size: 13px;
	letter-spacing: -0.07px;
	font-weight: 600;
	${({ active }) =>
		active &&
		css`
			&:: after {
				content: "";
				position: absolute;
				top: 3px;
				margin-left: 3px;
				width: 5px;
				height: 5px;
				border-radius: 100%;
				background-color: #f15746;
			}
		`}
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

const SubTitleActive = styled.div`
	margin-top: 4px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	font-size: 15px;
	letter-spacing: -0.15px;
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
