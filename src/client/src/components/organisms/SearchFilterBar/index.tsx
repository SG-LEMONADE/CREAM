import React, {
	FunctionComponent,
	useCallback,
	useEffect,
	useState,
} from "react";
import useSWR from "swr";

import { fetcher } from "lib/fetcher";
import Icon from "components/atoms/Icon";
import SearchFilterItem from "components/molecules/SearchFilterItem";

import styled from "@emotion/styled";

type SearchFilterBarProps = {
	luxaryFilter: boolean;
	setLuxaryFilter: React.Dispatch<React.SetStateAction<boolean>>;
	filteredCategory: string;
	setFilteredCategory: React.Dispatch<React.SetStateAction<string>>;
	filteredBrand: string[];
	setFilteredBrand: React.Dispatch<React.SetStateAction<string[]>>;
	filteredCollections: string[];
	setFilteredCollections: React.Dispatch<React.SetStateAction<string[]>>;
	filteredGender: string;
	setFilteredGender: React.Dispatch<React.SetStateAction<string>>;
};

const SearchFilterBar: FunctionComponent<SearchFilterBarProps> = (props) => {
	const {
		luxaryFilter,
		setLuxaryFilter,
		filteredCategory,
		setFilteredCategory,
		filteredBrand,
		setFilteredBrand,
		filteredCollections,
		setFilteredCollections,
		filteredGender,
		setFilteredGender,
	} = props;

	const [brandData, setBrandData] = useState<string[]>([]);
	const [collectionData, setCollectionData] = useState<string[]>([]);

	const { data, error } = useSWR(
		//`${process.env.END_POINT_PRODUCT}/filters`,
		"http://ec2-3-35-137-187.ap-northeast-2.compute.amazonaws.com:8081/filters",
		fetcher,
	);

	const onHandleDeleteAll = useCallback(() => {
		setLuxaryFilter(false);
		setFilteredCategory("");
		setFilteredBrand([]);
		setFilteredGender("");
	}, []);

	useEffect(() => {
		if (data) {
			setBrandData(data.brands.map((obj) => obj.name));
			setCollectionData(data.collections.map((obj) => obj.name));
		}
	}, [data]);

	useEffect(() => {
		console.log("--SearchFilterBar component--");
		console.log(luxaryFilter, filteredCategory, filteredBrand, filteredGender);
	}, [luxaryFilter, filteredCategory, filteredBrand, filteredGender]);

	return (
		<SearchFilterBarWrapper>
			<FilterStatusWrapper>
				<StatusBox>
					<StatusText>필터</StatusText>
					{(luxaryFilter ||
						filteredCategory.length > 0 ||
						filteredBrand.length > 0 ||
						filteredGender.length > 0) && <Icon name="TurnOn" />}
				</StatusBox>
				{(luxaryFilter ||
					filteredCategory.length > 0 ||
					filteredBrand.length > 0 ||
					filteredGender.length > 0) && (
					<StyledA onClick={onHandleDeleteAll}>모두 삭제</StyledA>
				)}
			</FilterStatusWrapper>
			<SearchFilterItem
				title="카테고리"
				optionsList={["의류", "스니커즈", "패션 잡화", "라이프", "테크"]}
				onlyOneChecked
				state={filteredCategory}
				cb={setFilteredCategory}
			/>
			<SearchFilterItem
				title="브랜드"
				optionsList={brandData}
				state={filteredBrand}
				cb={setFilteredBrand}
			/>
			<SearchFilterItem
				title="컬렉션"
				optionsList={collectionData}
				state={filteredCollections}
				cb={setFilteredCollections}
			/>

			<SearchFilterItem
				title="성별"
				optionsList={["남성", "여성", "공용"]}
				state={filteredGender}
				cb={setFilteredGender}
				onlyOneChecked
			/>
		</SearchFilterBarWrapper>
	);
};

export default SearchFilterBar;

const SearchFilterBarWrapper = styled.div`
	margin: 0;
	padding: 0;
`;

const FilterStatusWrapper = styled.div`
	display: flex;
	align-items: center;
	padding: 23px 0 15px;
	justify-content: space-between;
`;

const StatusBox = styled.div`
	display: flex;
	align-items: center;
`;

const StatusText = styled.span`
	font-size: 14px;
	letter-spacing: -0.21px;
	font-weight: 700;
	margin-right: 10px;
`;

const StyledA = styled.a`
	text-decoration: underline;
	font-size: 13px;
	letter-spacing: -0.07px;
	color: rgba(34, 34, 34, 0.5);
	cursor: pointer;
`;
