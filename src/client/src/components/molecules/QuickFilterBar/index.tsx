import React, { FunctionComponent, useEffect, useState } from "react";

import QuickFilter from "components/atoms/QuickFilter";
import Icon from "components/atoms/Icon";

import styled from "@emotion/styled";

type QuickFilterBarProps = {
	onApplyFilter: (luxury: boolean, category: string) => void;
};

const productCategory = ["스니커즈", "의류", "패션잡화", "라이프", "테크"];

const QuickFilterBar: FunctionComponent<QuickFilterBarProps> = (props) => {
	const { onApplyFilter } = props;

	const [filtered, setFiltered] = useState<boolean>(false);
	const [luxaryFilter, setLuxuryFilter] = useState<boolean>(false);
	const [activateItem, setActivateItem] = useState<string>("");

	const onHandleFilter = (content: string) => {
		if (content === activateItem) {
			setActivateItem("");
		} else setActivateItem(content);
	};

	useEffect(() => {
		onApplyFilter(luxaryFilter, activateItem);
		setFiltered(luxaryFilter || activateItem.length > 0);
	}, [luxaryFilter, activateItem]);

	return (
		<StyledQuickFilterWrapper>
			{filtered ? (
				<QuickFilter
					content={
						<Icon name="Filter" style={{ width: "20px", height: "20px" }} />
					}
					activate={true}
				/>
			) : (
				<QuickFilter
					content={
						<Icon name="Filter" style={{ width: "20px", height: "20px" }} />
					}
					activate={false}
				/>
			)}
			<QuickFilter
				onClick={() => setLuxuryFilter(!luxaryFilter)}
				content="럭셔리"
				activate={false}
			/>
			<StyledDivider />
			{productCategory.map((product) =>
				activateItem === product ? (
					<QuickFilter
						key={product}
						onClick={onHandleFilter}
						content={product}
						activate={true}
					/>
				) : (
					<QuickFilter
						key={product}
						onClick={onHandleFilter}
						content={product}
						activate={false}
					/>
				),
			)}
		</StyledQuickFilterWrapper>
	);
};

export default QuickFilterBar;

const StyledQuickFilterWrapper = styled.section`
	overflow-x: auto;
	overflow-y: hidden;
	padding-bottom: 16px;
	white-space: nowrap;
	a {
		margin-right: 8px;
	}
`;

const StyledDivider = styled.div`
	height: 32px;
	width: 3px;
	display: inline-block;
	background-color: #ebebeb;
	margin: 2px 8px 0 0;
`;
