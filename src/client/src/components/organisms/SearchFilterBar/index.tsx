import React, {
	FunctionComponent,
	useCallback,
	useEffect,
	useState,
} from "react";
import useSWR from "swr";
import { useRouter } from "next/router";

import { fetcher } from "lib/fetcher";
import Icon from "components/atoms/Icon";
import SearchFilterItem from "components/molecules/SearchFilterItem";

import styled from "@emotion/styled";

type SearchFilterBarProps = {
	setBrandId: React.Dispatch<React.SetStateAction<Map<string, number>>>;
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
	filteredPrice: string;
	setFilteredPrice: React.Dispatch<React.SetStateAction<string>>;
};

const SearchFilterBar: FunctionComponent<SearchFilterBarProps> = (props) => {
	const router = useRouter();
	const {
		setBrandId,
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
		filteredPrice,
		setFilteredPrice,
	} = props;

	const [brandData, setBrandData] = useState<string[]>([]);
	const [collectionData, setCollectionData] = useState<string[]>([]);

	const { data: filterDatas } = useSWR(
		`${process.env.END_POINT_PRODUCT}/filters`,
		fetcher,
		{
			revalidateOnFocus: false,
		},
	);

	const onHandleDeleteAll = useCallback(() => {
		setLuxaryFilter(false);
		setFilteredCategory("");
		setFilteredBrand([]);
		setFilteredGender("");
		setFilteredPrice("");
		router.push("/search");
	}, []);

	useEffect(() => {
		if (filterDatas) {
			let map = new Map();
			filterDatas.brands.forEach((brand) => {
				map.set(brand.name, brand.id);
			});
			setBrandId(map);
			setBrandData(filterDatas.brands.map((obj) => obj.name));
			setCollectionData(filterDatas.collections.map((obj) => obj.name));
		}
	}, [filterDatas]);

	return (
		<SearchFilterBarWrapper>
			<FilterStatusWrapper>
				<StatusBox>
					<StatusText>??????</StatusText>
					{(luxaryFilter ||
						filteredCategory.length > 0 ||
						filteredBrand.length > 0 ||
						filteredGender.length > 0 ||
						filteredPrice.length > 0) && <Icon name="TurnOn" />}
				</StatusBox>
				{(luxaryFilter ||
					filteredCategory.length > 0 ||
					filteredBrand.length > 0 ||
					filteredGender.length > 0 ||
					filteredPrice.length > 0) && (
					<StyledA onClick={onHandleDeleteAll}>?????? ??????</StyledA>
				)}
			</FilterStatusWrapper>
			<SearchFilterItem
				title="????????????"
				optionsList={["??????", "????????????", "?????? ??????", "?????????", "??????"]}
				onlyOneChecked
				state={filteredCategory}
				cb={setFilteredCategory}
			/>
			<SearchFilterItem
				title="?????????"
				optionsList={brandData}
				state={filteredBrand}
				cb={setFilteredBrand}
			/>
			<SearchFilterItem
				title="?????????"
				optionsList={collectionData}
				state={filteredCollections}
				cb={setFilteredCollections}
			/>
			<SearchFilterItem
				title="??????"
				optionsList={["??????", "??????", "??????"]}
				state={filteredGender}
				cb={setFilteredGender}
				onlyOneChecked
			/>
			<SearchFilterItem
				title="??????"
				optionsList={[
					"10?????? ??????",
					"10?????? ~ 30?????? ??????",
					"30?????? ~ 50?????? ??????",
					"50?????? ??????",
				]}
				onlyOneChecked
				state={filteredPrice}
				cb={setFilteredPrice}
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
