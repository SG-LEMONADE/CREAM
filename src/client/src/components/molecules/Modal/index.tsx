import React, { FunctionComponent, useState, useEffect } from "react";
import ReactDOM from "react-dom";

import styled from "@emotion/styled";
import Icon from "components/atoms/Icon";

type ModalProps = {
	category: "wish" | "else";
	show: boolean;
	onClose: () => void;
	children: React.ReactNode;
	title?: string;
};

const Modal: FunctionComponent<ModalProps> = (props) => {
	const { category, show, onClose, children, title } = props;

	const [isBrowser, setIsBrowser] = useState(false);

	const onHandleCloseClick = (
		e: React.MouseEvent<SVGSVGElement, MouseEvent>,
	) => {
		e.preventDefault();
		onClose();
	};

	useEffect(() => {
		setIsBrowser(true);
	}, []);

	const modalContent = show ? (
		<StyledModalOverlay onClick={onClose}>
			<StyledModal category={category} onClick={(e) => e.stopPropagation()}>
				<StyledModalHeader>
					<Icon
						name="Close"
						style={{
							position: "absolute",
							width: "24px",
							height: "24px",
							cursor: "pointer",
						}}
						onClick={onHandleCloseClick}
					/>
				</StyledModalHeader>
				{title && <StyledModalTitle>{title}</StyledModalTitle>}
				<StyledModalBody>{children}</StyledModalBody>
			</StyledModal>
		</StyledModalOverlay>
	) : null;

	if (isBrowser) {
		return ReactDOM.createPortal(
			modalContent,
			document.getElementById("modal-root"),
		);
	} else {
		return null;
	}
};

const StyledModalOverlay = styled.div`
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: flex;
	justify-content: center;
	align-items: center;
	background-color: rgba(0, 0, 0, 0.5);
`;

const StyledModal = styled.div<{ category: string }>`
	background: white;
	width: ${({ category }) => (category === "wish" ? "440px" : "480px")};
	height: ${({ category }) => (category === "wish" ? "527px" : "514px")};
	border-radius: 16px;
	padding: 15px;
`;

const StyledModalHeader = styled.div`
	display: flex;
	justify-content: flex-end;
	line-height: 22px;
`;

const StyledModalTitle = styled.h2`
	margin: 0;
	font-weight: 700;
	text-align: center;
	font-size: 18px;
	min-height: 30px;
	padding: 5px 50px 20px;
	letter-spacing: -0.15px;
	color: #000;
	background-color: #fff;
`;

const StyledModalBody = styled.div``;

export default Modal;
