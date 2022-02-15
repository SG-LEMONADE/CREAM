import React, {
	FunctionComponent,
	SetStateAction,
	useCallback,
	useState,
} from "react";

import Button from "components/atoms/Button";

import styled from "@emotion/styled";

type DeadLineProps = {
	setDueDate: React.Dispatch<SetStateAction<number>>;
};

const DeadLine: FunctionComponent<DeadLineProps> = (props) => {
	const { setDueDate } = props;

	const [selectedDue, setSelectedDue] = useState<string>("30일");

	const addDate = useCallback(
		(days: number) => {
			let result = new Date();
			result.setDate(result.getDate() + days);
			setDueDate(days);
			return result.toISOString().slice(0, 10);
		},
		[setDueDate],
	);

	return (
		<DeadLineWrapper>
			<DeadLineTitleWrapper>
				<StyledH3>입찰 마감기한</StyledH3>
			</DeadLineTitleWrapper>
			<DeadLineContents>
				<DueDateP>
					{selectedDue} ({addDate(parseInt(selectedDue.slice(0, -1)))}) 마감
				</DueDateP>
				<DueDateButtonWrapper>
					<Button
						style={{
							borderColor: selectedDue === "1일" ? `#222` : ``,
							color: selectedDue === "1일" ? `#222` : ``,
						}}
						category="primary"
						onClick={() => setSelectedDue("1일")}
					>
						1일
					</Button>
					<Button
						style={{
							borderColor: selectedDue === "3일" ? `#222` : ``,
							color: selectedDue === "3일" ? `#222` : ``,
						}}
						category="primary"
						onClick={() => setSelectedDue("3일")}
					>
						3일
					</Button>
					<Button
						style={{
							borderColor: selectedDue === "7일" ? `#222` : ``,
							color: selectedDue === "7일" ? `#222` : ``,
						}}
						category="primary"
						onClick={() => setSelectedDue("7일")}
					>
						7일
					</Button>
					<Button
						style={{
							borderColor: selectedDue === "30일" ? `#222` : ``,
							color: selectedDue === "30일" ? `#222` : ``,
						}}
						category="primary"
						onClick={() => setSelectedDue("30일")}
					>
						30일
					</Button>
					<Button
						style={{
							borderColor: selectedDue === "60일" ? `#222` : ``,
							color: selectedDue === "60일" ? `#222` : ``,
						}}
						category="primary"
						onClick={() => setSelectedDue("60일")}
					>
						60일
					</Button>
				</DueDateButtonWrapper>
			</DeadLineContents>
		</DeadLineWrapper>
	);
};

export default DeadLine;

const DeadLineWrapper = styled.div`
	margin: 0;
	padding: 32px;
	border-top: 8px solid #fafafa;
`;

const DeadLineTitleWrapper = styled.div`
	margin: 0;
	padding: 0;
	padding-bottom: 16px;
`;

const StyledH3 = styled.h3`
	margin: 0;
	padding: 0;
	font-size: 14px;
	letter-spacing: -0.21px;
`;

const DeadLineContents = styled.div``;

const DueDateP = styled.p`
	margin: 0;
	padding: 0;
	font-size: 15px;
	letter-spacing: -0.15px;
`;

const DueDateButtonWrapper = styled.div`
	margin-top: 15px;
	display: grid;
	grid-template-columns: repeat(5, 1fr);
	gap: 5px;
`;
