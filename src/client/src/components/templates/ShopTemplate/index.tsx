import React, {
	FunctionComponent,
	SetStateAction,
	useCallback,
	useEffect,
	useState,
} from "react";
import { useRouter } from "next/router";

import ShopTopBox from "components/organisms/ShopTopBox";
import Slider from "components/organisms/Slider";
import BannerImage from "components/atoms/BannerImage";
import TagItem from "components/atoms/TagItem";
import SearchFilterBar from "components/organisms/SearchFilterBar";
import Dropdown from "components/molecules/Dropdown";
import { smallImageInfos } from "utils/images";
import { queryMaker } from "utils/query";

import styled from "@emotion/styled";
import { css } from "@emotion/react";

type ShopTemplateProps = {
	isLoading?: boolean;
	cb?: React.Dispatch<SetStateAction<boolean>>;
	children: React.ReactNode;
};

const ShopTemplate: FunctionComponent<ShopTemplateProps> = (props) => {
	const { children, isLoading = false, cb } = props;

	const router = useRouter();

	const [scrolled, setScrolled] = useState<boolean>(false);

	const [brandId, setBrandId] = useState<Map<string, number>>();

	const [luxaryFilter, setLuxaryFilter] = useState<boolean>(false);
	const [filteredCategory, setFilteredCategory] = useState<string>("");
	const [filteredBrand, setFilteredBrand] = useState<string[]>([]);
	const [filteredCollections, setFilteredCollections] = useState<string[]>([]);
	const [filteredGender, setFilteredGender] = useState<string>("");
	const [filteredPrice, setFilteredPrice] = useState<string>("");
	const [sortOption, setSortOption] = useState<string>("");

	const onHandleQuickFilter = useCallback(
		(luxary: boolean, category: string) => {
			setLuxaryFilter(luxary);
			setFilteredCategory(category);
		},
		[],
	);

	useEffect(() => {
		const query = queryMaker(
			filteredCategory,
			filteredBrand.map((brand) => brandId.get(brand)),
			filteredCollections,
			filteredGender,
			filteredPrice,
			sortOption,
		);
		if (Object.keys(query).length > 0) {
			router &&
				router.push({
					pathname: "/search",
					query: query,
				});
			cb(false);
		}
	}, [
		luxaryFilter,
		filteredCategory,
		filteredBrand,
		filteredGender,
		filteredPrice,
		sortOption,
		brandId,
	]);

	const handleScroll = useCallback(() => {
		setScrolled(window.scrollY > 0);
	}, []);

	useEffect(() => {
		window.addEventListener("scroll", handleScroll);
		return () => window.removeEventListener("scroll", handleScroll);
	});

	return (
		<ShopTemplateWrapper>
			<ShopTopBoxWrapper scrolled={scrolled}>
				<ShopTopBox
					luxaryActivateState={luxaryFilter}
					filteredCategory={filteredCategory}
					onApplyFilter={onHandleQuickFilter}
				/>
			</ShopTopBoxWrapper>
			<ShopContentsWrapper scrolled={scrolled}>
				<BannerWrapper>
					<Slider
						small={true}
						images={smallImageInfos.map((info) => (
							<BannerImage
								bgColor={info.bgColor}
								category="small"
								src={info.src}
							/>
						))}
					/>
				</BannerWrapper>
				<ContentsWrapper>
					<SearchFilterWrapper>
						<SearchFilterBar
							setBrandId={setBrandId}
							luxaryFilter={luxaryFilter}
							setLuxaryFilter={setLuxaryFilter}
							filteredCategory={filteredCategory}
							setFilteredCategory={setFilteredCategory}
							filteredBrand={filteredBrand}
							setFilteredBrand={setFilteredBrand}
							filteredCollections={filteredCollections}
							setFilteredCollections={setFilteredCollections}
							filteredGender={filteredGender}
							setFilteredGender={setFilteredGender}
							filteredPrice={filteredPrice}
							setFilteredPrice={setFilteredPrice}
						/>
					</SearchFilterWrapper>
					<SearchContentWrapper>
						<SearchContentOption>
							<FilteredTags>
								{luxaryFilter && (
									<TagItem onClick={() => setLuxaryFilter(false)}>
										럭셔리
									</TagItem>
								)}
								{filteredCategory.length > 0 && (
									<TagItem onClick={() => setFilteredCategory("")}>
										{filteredCategory}
									</TagItem>
								)}
								{filteredBrand.length > 0 &&
									filteredBrand.map((option) => (
										<TagItem
											key={option}
											onClick={() =>
												setFilteredBrand(
													filteredBrand.filter((brand) => brand !== option),
												)
											}
										>
											{option}
										</TagItem>
									))}
								{filteredCollections.length > 0 &&
									filteredCollections.map((option) => (
										<TagItem
											key={option}
											onClick={() =>
												setFilteredCollections(
													filteredCollections.filter((col) => col !== option),
												)
											}
										>
											{option}
										</TagItem>
									))}
								{filteredGender.length > 0 && (
									<TagItem onClick={() => setFilteredGender("")}>
										{filteredGender}
									</TagItem>
								)}
								{filteredPrice.length > 0 && (
									<TagItem onClick={() => setFilteredPrice("")}>
										{filteredPrice}
									</TagItem>
								)}
							</FilteredTags>
							<SortWrapper>
								<Dropdown
									onClickSort={(sortOption: string) =>
										setSortOption(sortOption)
									}
								/>
							</SortWrapper>
						</SearchContentOption>
						{isLoading && <SearchLoading>{children}</SearchLoading>}
						{!isLoading &&
							(React.Children.count(children) > 0 ? (
								<SearchContent>{children}</SearchContent>
							) : (
								<SearchEmptyConent>
									<p style={{ fontSize: "16px", color: "rgba(34,34,34,.8)" }}>
										검색하신 결과가 없습니다.
									</p>
									<p style={{ fontSize: "13px", color: "rgba(34,34,34,.8)" }}>
										상품 등록 요청은 <strong>대면</strong> 으로 요청해주세요.
									</p>
								</SearchEmptyConent>
							))}
					</SearchContentWrapper>
				</ContentsWrapper>
			</ShopContentsWrapper>
		</ShopTemplateWrapper>
	);
};

export default ShopTemplate;

const ShopTemplateWrapper = styled.div`
	overflow: hidden;
	margin: 0;
	padding: 0;
	padding-top: 100px;
`;

const ShopTopBoxWrapper = styled.div<{ scrolled: boolean }>`
	${({ scrolled }) =>
		scrolled &&
		css`
			position: fixed;
			top: 99px;
			left: 0;
			right: 0;
			border-bottom: 1px solid #ebebeb;
			z-index: 50;
		`}
`;

const ShopContentsWrapper = styled.div<{ scrolled: boolean }>`
	${({ scrolled }) =>
		scrolled &&
		css`
			padding-top: 175px;
		`}
	@media screen and (max-width: 1240px) {
		padding: 0 40px 0;
		${({ scrolled }) =>
			scrolled &&
			css`
				padding-top: 175px;
			`}
	}
`;

const BannerWrapper = styled.div`
	max-width: 1200px;
	margin: 0 auto;
	text-align: center;
`;

const ContentsWrapper = styled.div`
	display: flex;
	position: relative;
	margin: 0 auto;
	// STRANGE - 0 40 80;
	padding: 0 0 80px;
	max-width: 1200px;
`;

const SearchFilterWrapper = styled.div`
	width: 210px;
	margin-right: 10px;
	padding-right: 10px;
	overflow-x: hidden;
	overflow-y: auto;
`;

const SearchContentWrapper = styled.article`
	margin: 0;
	padding: 0;
	flex: 1;
`;

const SearchContentOption = styled.div`
	display: flex;
	justify-content: space-between;
	align-items: center;
	height: 68px;
`;

const FilteredTags = styled.div`
	display: flex;
	flex-wrap: wrap;
`;

const SortWrapper = styled.div`
	position: relative;
`;

const SearchContent = styled.div`
	display: grid;
	grid-template-columns: repeat(4, 1fr);
	@media screen and (max-width: 1000px) {
		grid-template-columns: repeat(3, 1fr);
	}
	@media screen and (max-width: 880px) {
		grid-template-columns: repeat(2, 1fr);
	}
	gap: 70px 20px;
	overflow-y: auto;
	position: relative;
`;

const SearchLoading = styled.div`
	display: flex;
	margin-top: 120px;
	justify-content: center;
	align-items: center;
`;

export const SearchEmptyConent = styled.div`
	position: relative;
	padding: 120px 0 100px;
	background-color: #fff;
	text-align: center;
`;

export const StatusText = styled.p`
	padding-left: max(10%, 40px);
	padding-bottom: 5%;
	font-size: 16px;
	color: rgba(34, 34, 34, 0.9);
	font-weight: 700;
`;
