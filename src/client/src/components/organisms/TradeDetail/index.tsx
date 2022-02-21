import React, { FunctionComponent } from "react";
import axios from "axios";
import Link from "next/link";

import TradeTab from "components/molecules/TradeTab";
import TradeHistoryItem from "components/molecules/TradeHistoryItem";
import { TradeHistoryItemRes } from "types";
import { getToken } from "lib/token";

import styled from "@emotion/styled";
import { useRouter } from "next/router";
import Swal from "sweetalert2";

type TradeDetailProps = {
	category: "buy" | "sell";
	waiting: number;
	in_progress: number;
	finished: number;
	filter: string;
	onClick: React.Dispatch<React.SetStateAction<string>>;
	items: TradeHistoryItemRes[];
};

const TradeDetail: FunctionComponent<TradeDetailProps> = (props) => {
	const router = useRouter();

	const { category, waiting, in_progress, finished, items, filter, onClick } =
		props;

	const onHandleDelete = async (id: number) => {
		const token = getToken("accessToken");
		try {
			await axios.delete(`${process.env.END_POINT_PRODUCT}/trades/${id}`, {
				headers: {
					Authorization: `Bearer ${token}`,
				},
			});
			Swal.fire({
				position: "top",
				icon: "success",
				html: `${category === "buy" ? `구매` : `판매`} 입찰이 삭제되었습니다!`,
				showConfirmButton: true,
				didClose: () => router.reload(),
			});
		} catch (e) {
			console.error(e);
		}
	};

	return (
		<TradeDetailWrapper>
			<TradeTab
				category={category}
				waiting={waiting}
				in_progress={in_progress}
				finished={finished}
				filter={filter}
				onClick={onClick}
			/>
			<StyledBar>
				<StyledTextLeft>제품</StyledTextLeft>
				<StyledTextPrice right={filter === "WAITING"}>가격</StyledTextPrice>
				<StyledText right={filter === "WAITING"}>만료일</StyledText>
			</StyledBar>
			{items.length > 0 ? (
				items.map((item) => (
					<Link href={`/products/${item.productId}`} passHref>
						<a>
							<TradeHistoryItem
								id={item.id}
								key={`${item.imageUrl[0]}/${item.validationDate}/${item.size}/${item.id}`}
								imgSrc={item.imageUrl[0]}
								backgroundColor={item.backgroundColor}
								productName={item.name}
								size={item.size}
								price={item.price ? item.price : 140000}
								expiredDate={item.validationDate}
								status={item.tradeStatus}
								onDelete={onHandleDelete}
							/>
						</a>
					</Link>
				))
			) : (
				<TradeDetailEmptySection>
					<StyledP>거래 내역이 없습니다.</StyledP>
				</TradeDetailEmptySection>
			)}
		</TradeDetailWrapper>
	);
};

export default TradeDetail;

const TradeDetailWrapper = styled.section``;

const StyledBar = styled.div`
	display: flex;
	padding: 10px;
	align-items: center;
	justify-content: space-between;
	border-bottom: 1px solid #ebebeb;
`;

const StyledTextLeft = styled.p`
	margin: 0;
	padding: 0;
	position: relative;
	display: inline-block;
	font-size: 13px;
	letter-spacing: -0.07px;
	line-height: 24px;
	padding-left: 5%;
	font-weight: 600;
`;

const StyledTextPrice = styled.p<{ right: boolean }>`
	margin: 0;
	padding: 0;
	display: inline-block;
	position: relative;
	font-size: 13px;
	letter-spacing: -0.07px;
	line-height: 24px;
	margin-left: ${({ right }) => (right ? `50%` : `60%`)};
	font-weight: 600;
`;

const StyledText = styled.p<{ right: boolean }>`
	margin: 0;
	padding: 0;
	position: relative;
	padding-right: ${({ right }) => (right ? `105px` : `20px`)};
	display: inline-block;
	font-size: 13px;
	letter-spacing: -0.07px;
	line-height: 24px;
	font-weight: 600;
`;

export const StyledH3 = styled.h3`
	line-height: 29px;
	font-size: 24px;
	letter-spacing: -0.36px;
`;

const TradeDetailEmptySection = styled.div`
	padding: 80px 0;
	text-align: center;
`;

const StyledP = styled.p`
	font-size: 13px;
	letter-spacing: -0.07px;
	color: rgba(34, 34, 34, 0.5);
`;
