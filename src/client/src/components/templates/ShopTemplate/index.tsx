import React, {
	FunctionComponent,
	useCallback,
	useEffect,
	useState,
} from "react";

import ShopTopBox from "components/organisms/ShopTopBox";
import Slider from "components/organisms/Slider";
import BannerImage from "components/atoms/BannerImage";
import TagItem from "components/atoms/TagItem";
import SearchFilterBar from "components/organisms/SearchFilterBar";

import styled from "@emotion/styled";
import { css } from "@emotion/react";

type ShopTemplateProps = {
	children: React.ReactNode;
};

const ImageInfos = [
	{
		bgColor: "#4a4a4a",
		category: "small",
		src: "https://kream-phinf.pstatic.net/MjAyMjAxMTFfMjA1/MDAxNjQxODkwNjY5NDI5.6NPmF_WbPm9sX5lW9BE2PcQlkMRAvFxDy7bryYVsDc4g.8YA62__XKcpRvDp-m3k22k1ib0Larluka04T22wL2Ycg.PNG/a_586211b5374344ffa601d2379799d0f0.png",
	},
	{
		bgColor: "#0CB459",
		category: "small",
		src: "https://kream-phinf.pstatic.net/MjAyMTExMDhfMTQg/MDAxNjM2MzUyODQ4MTAy.Cw85PX23DLnCC0JXxlf5uRR4V6OUxDsz12MQLHRVeXsg.xdWI38nU5YX5e8cq6zifnXghc7o6Jl26o0U_vV7QVbkg.PNG/a_4e25f1b123af4f79ab8eb2c243321230.png",
	},
	{
		bgColor: "#ECE3F4",
		category: "small",
		src: "https://kream-phinf.pstatic.net/MjAyMTA4MTBfMTM0/MDAxNjI4NTM2NzQwNzI2.PFukx8j7Xo8kbhUCYJNc8Vx8wsQObtdjh0E3qCLbpq8g.0_OMaQNb714BoMvFdCXQsEMNSbYtD2WvNW-0-v8iHLcg.JPEG/a_499eb6d55b8c4e71b32e909bb1586e10.jpg",
	},
	{
		bgColor: "#3C31BB",
		category: "small",
		src: "https://kream-phinf.pstatic.net/MjAyMTA4MDJfMjg2/MDAxNjI3ODg3NjYxMjc0.qPz4jY6pgcqhai_G23z-Iwa-Z5jcp-fYj1OKVEMpAzog.ntI1W2Fy8KutXWMUSzW6gXb9b5_cMc0DZ6WEBAXJenAg.JPEG/p_7766440af0194c368eaf4c6dd1f4a9c9.jpg",
	},
];

const ShopTemplate: FunctionComponent<ShopTemplateProps> = (props) => {
	const { children } = props;

	const [scrolled, setScrolled] = useState<boolean>(false);

	const [luxaryFilter, setLuxaryFilter] = useState<boolean>(false);
	const [filteredCategory, setFilteredCategory] = useState<string>("");
	const [filteredBrand, setFilteredBrand] = useState<string[]>([]);
	const [filteredCollections, setFilteredCollections] = useState<string[]>([]);
	const [filteredGender, setFilteredGender] = useState<string>("");
	const [filteredPrice, setFilteredPrice] = useState<string[]>([]);

	const onHandleQuickFilter = useCallback(
		(luxary: boolean, category: string) => {
			setLuxaryFilter(luxary);
			setFilteredCategory(category);
		},
		[],
	);

	useEffect(() => {
		console.log("===========shopTemplate Rendered!============");
		console.log(luxaryFilter);
		console.log(filteredCategory);
		console.log(filteredBrand);
		console.log(filteredGender);
		console.log(filteredPrice);
	}, [
		luxaryFilter,
		filteredCategory,
		filteredBrand,
		filteredGender,
		filteredPrice,
	]);

	const handleScroll = () => {
		setScrolled(window.scrollY > 0);
	};

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
						images={ImageInfos.map((info) => (
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
								{filteredPrice.length > 0 &&
									filteredPrice.map((option) => (
										<TagItem
											onClick={() =>
												setFilteredPrice(
													filteredPrice.filter((price) => price !== option),
												)
											}
										>
											{option}
										</TagItem>
									))}
							</FilteredTags>
							<SortWrapper>
								<SortContent>인기순</SortContent>
							</SortWrapper>
						</SearchContentOption>
						<SearchContent>{children}</SearchContent>
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

const SortContent = styled.div`
	display: flex;
	align-items: center;
	cursor: pointer;
	font-size: 14px;
	letter-spacing: -0.21px;
	font-weight: 600;
	:after {
		content: "";
		margin-left: 2px;
		display: inline-flex;
		width: 24px;
		height: 24px;
		background: url(data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIGZpbGw9Im5vbmUiIHZpZXdCb3g9IjAgMCAyNCAyNCI+PHBhdGggZmlsbD0iIzIyMiIgZmlsbC1ydWxlPSJldmVub2RkIiBkPSJNNi40NyAxOS41M2wuNTMuNTMuNTMtLjUzIDQtNC0xLjA2LTEuMDYtMi43MiAyLjcyVjVoLTEuNXYxMi4xOWwtMi43Mi0yLjcyLTEuMDYgMS4wNiA0IDR6TTE3LjUzIDQuNDdMMTcgMy45NGwtLjUzLjUzLTQgNCAxLjA2IDEuMDYgMi43Mi0yLjcyVjE5aDEuNVY2LjgxbDIuNzIgMi43MiAxLjA2LTEuMDYtNC00eiIgY2xpcC1ydWxlPSJldmVub2RkIi8+PC9zdmc+)
			no-repeat;
	}
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
`;
