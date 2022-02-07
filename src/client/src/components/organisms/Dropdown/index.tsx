import React, {
	FunctionComponent,
	useCallback,
	useState,
	useEffect,
} from "react";

import styled from "@emotion/styled";

type DropdownProps = {
	onClickSort: (sort: string) => void;
};

const Dropdown: FunctionComponent<DropdownProps> = (props) => {
	const { onClickSort } = props;
	const [isShow, setIsShow] = useState<boolean>(false);
	const [currentSort, setCurrentSort] = useState<string>("인기순");

	const [scrolled, setScrolled] = useState<boolean>(false);

	const contents = [
		"인기순",
		"발매일 최신순",
		"프리미엄순",
		"즉시 구매가순",
		"즉시 판매가순",
	];

	const subContents = {
		인기순: "많이 판매된 순서대로 정렬합니다.",
		"발매일 최신순": "최신상품 순서대로 정렬합니다.",
		프리미엄순: "발매가 대비 가격이 높은 순서대로 정렬합니다.",
		"즉시 구매가순": "즉시 구매가가 낮은 순서대로 정렬합니다.",
		"즉시 판매가순": "즉시 판매가가 높은 순서대로 정렬합니다.",
	};

	const onHandleCurrentSort = useCallback(
		(content: string) => {
			setCurrentSort(content);
			setIsShow(false);
			onClickSort(content);
		},
		[onClickSort],
	);

	const handleScroll = useCallback(() => {
		setScrolled(window.scrollY > 0);
		setIsShow(scrolled);
	}, []);

	useEffect(() => {
		window.addEventListener("scroll", handleScroll);
		return () => window.removeEventListener("scroll", handleScroll);
	});

	return (
		<>
			<SortContent onClick={() => setIsShow(!isShow)}>
				{currentSort}
			</SortContent>
			{isShow && (
				<StyledDropdownWrapper onClick={() => setIsShow(false)}>
					<DropdownParent>
						<DropdownMenu show={isShow} scrolled={scrolled}>
							{contents.map((content) => (
								<DropdownItem
									active={content === currentSort}
									key={content}
									onClick={() => onHandleCurrentSort(content)}
								>
									<MainText>{content}</MainText>
									<SubText>{subContents[content]}</SubText>
								</DropdownItem>
							))}
						</DropdownMenu>
					</DropdownParent>
				</StyledDropdownWrapper>
			)}
		</>
	);
};

export default Dropdown;

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

const StyledDropdownWrapper = styled.div`
	position: fixed;
	top: 0;
	right: 0;
	width: 100%;
	height: 100%;
	z-index: 100;
`;

const DropdownParent = styled.div`
	position: relative;
	max-width: 1200px;
	padding-top: 430px;
	margin: auto;
	@media screen and (max-width: 1240px) {
		margin: 0 40px 0;
	}
`;

const DropdownMenu = styled.div<{ show: boolean; scrolled: boolean }>`
	display: ${({ show }) => (show ? `block` : `none`)};
	position: absolute;
	background: "#a9c1c1";
	width: 300px;
	border: 2px solid #efefef;
	background-color: #fff;
	border-radius: 8px;
	right: 0px;
	margin-top: 10px;
	font-size: 14px;
	box-shadow: 10px 10px 5px #efefef;
`;

const DropdownItem = styled.div<{ active: boolean }>`
	padding: 12px 36px 12px 16px;
	&:hover {
		background-color: #222;
		color: #fff;
		cursor: pointer;
		border-radius: 8px;
		transition: all 0.45s linear;
	}
	font-weight: ${({ active }) => (active ? `800` : ``)};
	color: ${({ active }) => (active ? `black` : `rgba(34,34,34,.8);}`)};
`;

const MainText = styled.p`
	font-size: 14px;
	letter-spacing: -0.21px;
	margin: 0;
	padding: 0;
`;

const SubText = styled.p`
	margin: 0;
	padding: 0;
	padding-top: 6px;
	font-size: 12px;
	letter-spacing: -0.06px;
`;
