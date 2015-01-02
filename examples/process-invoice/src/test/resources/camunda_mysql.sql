-- Adminer 4.1.0 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

CREATE DATABASE `camunda` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `camunda`;

DROP TABLE IF EXISTS `ACT_GE_BYTEARRAY`;
CREATE TABLE `ACT_GE_BYTEARRAY` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTES_` longblob,
  `GENERATED_` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_BYTEARR_DEPL` (`DEPLOYMENT_ID_`),
  CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `ACT_RE_DEPLOYMENT` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `ACT_GE_BYTEARRAY` (`ID_`, `REV_`, `NAME_`, `DEPLOYMENT_ID_`, `BYTES_`, `GENERATED_`) VALUES
('afdf7c1f-8f8c-11e4-a486-0a0027000000',	1,	'invoice.bpmn',	'afdf7c1e-8f8c-11e4-a486-0a0027000000',	'<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<definitions xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns=\"http://www.omg.org/spec/BPMN/20100524/MODEL\" xmlns:activiti=\"http://activiti.org/bpmn\" xmlns:bpmndi=\"http://www.omg.org/spec/BPMN/20100524/DI\" xmlns:omgdc=\"http://www.omg.org/spec/DD/20100524/DC\" xmlns:omgdi=\"http://www.omg.org/spec/DD/20100524/DI\" xmlns:signavio=\"http://www.signavio.com\" xsi:schemaLocation=\"http://www.omg.org/spec/BPMN/20100524/MODEL BPMN20.xsd\" id=\"sid-0b0aaa25-3baf-4875-9d7a-0907d599a9ef\" exporter=\"Signavio Process Editor, http://www.signavio.com\" exporterVersion=\"5.4.1\" targetNamespace=\"http://www.omg.org/spec/BPMN/20100524/MODEL\">\n  <dataStore id=\"FinancialAccountingSystem\" isUnlimited=\"false\" name=\"Financial Accounting System\">\n    <dataState id=\"DataState_1\"/>\n  </dataStore>\n  <message id=\"foxMessage_en\" name=\"foxMessage_en\"/>\n  <collaboration id=\"collaboration_3\">\n    <participant id=\"Process_Engine_1\" name=\"Invoice Receipt\" processRef=\"invoice\"/>\n  </collaboration>\n  <process id=\"invoice\" name=\"Invoice Receipt\" isExecutable=\"true\">\n    <laneSet id=\"laneSet_5\">\n      <lane id=\"Approver\" name=\"Approver\">\n        <flowNodeRef>approveInvoice</flowNodeRef>\n        <flowNodeRef>invoice_approved</flowNodeRef>\n      </lane>\n      <lane id=\"teamAssistant\" name=\"Team Assistant\">\n        <flowNodeRef>reviewInvoice</flowNodeRef>\n        <flowNodeRef>reviewSuccessful_gw</flowNodeRef>\n        <flowNodeRef>assignApprover</flowNodeRef>\n        <flowNodeRef>StartEvent_1</flowNodeRef>\n        <flowNodeRef>invoiceNotProcessed</flowNodeRef>\n      </lane>\n      <lane id=\"Accountant\" name=\"Accountant\">\n        <flowNodeRef>prepareBankTransfer</flowNodeRef>\n        <flowNodeRef>invoiceProcessed</flowNodeRef>\n        <flowNodeRef>ServiceTask_1</flowNodeRef>\n      </lane>\n    </laneSet>\n    <userTask id=\"approveInvoice\" activiti:formKey=\"embedded:app:forms/approve-invoice.html\" activiti:assignee=\"${approver}\" activiti:dueDate=\"${dateTime().plusWeeks(1).toDate()}\" name=\"Approve Invoice\">\n      <documentation>Approve the invoice (or not).</documentation>\n      <incoming>sequenceFlow_178</incoming>\n      <incoming>reviewSuccessful</incoming>\n      <outgoing>sequenceFlow_180</outgoing>\n    </userTask>\n    <exclusiveGateway id=\"invoice_approved\" name=\"Invoice&#xA;approved?\" gatewayDirection=\"Diverging\">\n      <incoming>sequenceFlow_180</incoming>\n      <outgoing>invoiceNotApproved</outgoing>\n      <outgoing>invoiceApproved</outgoing>\n    </exclusiveGateway>\n    <userTask id=\"reviewInvoice\" activiti:assignee=\"demo\" activiti:formKey=\"embedded:app:forms/review-invoice.html\" activiti:dueDate=\"${dateTime().plusDays(2).toDate()}\" name=\"Review Invoice\">\n      <documentation><![CDATA[Review the invoice.\n\n\nIf data is missing, provide it.]]></documentation>\n      <incoming>invoiceNotApproved</incoming>\n      <outgoing>sequenceFlow_183</outgoing>\n    </userTask>\n    <exclusiveGateway id=\"reviewSuccessful_gw\" name=\"Review&#xA;successful?\" gatewayDirection=\"Diverging\">\n      <incoming>sequenceFlow_183</incoming>\n      <outgoing>reviewNotSuccessful</outgoing>\n      <outgoing>reviewSuccessful</outgoing>\n    </exclusiveGateway>\n    <userTask id=\"prepareBankTransfer\" activiti:formKey=\"embedded:app:forms/prepare-bank-transfer.html\" activiti:candidateGroups=\"accounting\" activiti:dueDate=\"${dateTime().plusWeeks(1).toDate()}\" name=\"Prepare&#xD;&#xA;Bank&#xD;&#xA;Transfer\">\n      <documentation>Prepare the bank transfer.</documentation>\n      <incoming>invoiceApproved</incoming>\n      <outgoing>SequenceFlow_2</outgoing>\n    </userTask>\n    <sequenceFlow id=\"invoiceNotApproved\" name=\"no\" isImmediate=\"true\" sourceRef=\"invoice_approved\" targetRef=\"reviewInvoice\">\n      <conditionExpression xsi:type=\"tFormalExpression\" id=\"conditionExpression_56\">${!approved}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"sequenceFlow_180\" isImmediate=\"true\" sourceRef=\"approveInvoice\" targetRef=\"invoice_approved\"/>\n    <sequenceFlow id=\"sequenceFlow_183\" isImmediate=\"true\" sourceRef=\"reviewInvoice\" targetRef=\"reviewSuccessful_gw\"/>\n    <sequenceFlow id=\"invoiceApproved\" name=\"yes\" isImmediate=\"true\" sourceRef=\"invoice_approved\" targetRef=\"prepareBankTransfer\">\n      <conditionExpression xsi:type=\"tFormalExpression\" id=\"conditionExpression_63\">${approved}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"reviewNotSuccessful\" name=\"no\" isImmediate=\"true\" sourceRef=\"reviewSuccessful_gw\" targetRef=\"invoiceNotProcessed\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${!clarified}</conditionExpression>\n    </sequenceFlow>\n    <sequenceFlow id=\"reviewSuccessful\" name=\"yes\" isImmediate=\"true\" sourceRef=\"reviewSuccessful_gw\" targetRef=\"approveInvoice\">\n      <conditionExpression xsi:type=\"tFormalExpression\">${clarified}</conditionExpression>\n    </sequenceFlow>\n    <dataStoreReference id=\"DataStoreReference_1\" name=\"Financial Accounting System\" dataStoreRef=\"FinancialAccountingSystem\"/>\n    <userTask id=\"assignApprover\" activiti:formKey=\"embedded:app:forms/assign-approver.html\" activiti:assignee=\"demo\" activiti:dueDate=\"${dateTime().plusDays(3).toDate()}\" name=\"Assign Approver\">\n      <documentation>Select the colleague who should approve this invoice.</documentation>\n      <incoming>SequenceFlow_1</incoming>\n      <outgoing>sequenceFlow_178</outgoing>\n    </userTask>\n    <sequenceFlow id=\"sequenceFlow_178\" isImmediate=\"true\" sourceRef=\"assignApprover\" targetRef=\"approveInvoice\"/>\n    <sequenceFlow id=\"SequenceFlow_2\" name=\"\" sourceRef=\"prepareBankTransfer\" targetRef=\"ServiceTask_1\"/>\n    <startEvent id=\"StartEvent_1\" activiti:formKey=\"embedded:app:forms/start-form.html\" name=\"Invoice&#xA;received\">\n      <outgoing>SequenceFlow_1</outgoing>\n    </startEvent>\n    <sequenceFlow id=\"SequenceFlow_1\" name=\"\" sourceRef=\"StartEvent_1\" targetRef=\"assignApprover\"/>\n    <endEvent id=\"invoiceNotProcessed\" name=\"Invoice not&#xA;processed\">\n      <incoming>reviewNotSuccessful</incoming>\n    </endEvent>\n    <endEvent id=\"invoiceProcessed\" name=\"Invoice&#xA;processed\">\n      <incoming>SequenceFlow_3</incoming>\n    </endEvent>\n    <serviceTask id=\"ServiceTask_1\" activiti:class=\"org.camunda.bpm.example.invoice.service.ArchiveInvoiceService\" activiti:async=\"true\" name=\"Archive Invoice\">\n      <incoming>SequenceFlow_2</incoming>\n      <outgoing>SequenceFlow_3</outgoing>\n    </serviceTask>\n    <sequenceFlow id=\"SequenceFlow_3\" name=\"\" sourceRef=\"ServiceTask_1\" targetRef=\"invoiceProcessed\"/>\n    <association id=\"Association_1\" sourceRef=\"DataStoreReference_1\" targetRef=\"prepareBankTransfer\"/>\n  </process>\n  <bpmndi:BPMNDiagram id=\"BPMNDiagram_73\">\n    <bpmndi:BPMNPlane id=\"BPMNPlane_73\" bpmnElement=\"collaboration_3\">\n      <bpmndi:BPMNShape id=\"Process_Engine_1_gui\" bpmnElement=\"Process_Engine_1\" isHorizontal=\"true\">\n        <omgdc:Bounds height=\"486.0\" width=\"1009.0\" x=\"0.0\" y=\"0.0\"/>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Freigebender_105_gui\" bpmnElement=\"Approver\" isHorizontal=\"true\">\n        <omgdc:Bounds height=\"161.0\" width=\"979.0\" x=\"30.0\" y=\"182.0\"/>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Team-Assistenz_110_gui\" bpmnElement=\"teamAssistant\" isHorizontal=\"true\">\n        <omgdc:Bounds height=\"183.0\" width=\"979.0\" x=\"30.0\" y=\"0.0\"/>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Buchhaltung_119_gui\" bpmnElement=\"Accountant\" isHorizontal=\"true\">\n        <omgdc:Bounds height=\"144.0\" width=\"979.0\" x=\"30.0\" y=\"342.0\"/>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Rechnung_freigeben_125_gui\" bpmnElement=\"approveInvoice\" isHorizontal=\"true\">\n        <omgdc:Bounds height=\"80.0\" width=\"100.0\" x=\"353.0\" y=\"224.0\"/>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Freigabe_erfolgt__131_gui\" bpmnElement=\"invoice_approved\" isHorizontal=\"true\" isMarkerVisible=\"true\">\n        <omgdc:Bounds height=\"40.0\" width=\"40.0\" x=\"488.0\" y=\"244.0\"/>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"22.0\" width=\"107.0\" x=\"455.0\" y=\"289.0\"/>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Freigebenden_zuordnen_143_gui\" bpmnElement=\"assignApprover\" isHorizontal=\"true\">\n        <omgdc:Bounds height=\"80.0\" width=\"100.0\" x=\"180.0\" y=\"52.0\"/>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Rechnung_kl_ren_148_gui\" bpmnElement=\"reviewInvoice\" isHorizontal=\"true\">\n        <omgdc:Bounds height=\"80.0\" width=\"100.0\" x=\"548.0\" y=\"52.0\"/>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Kl_rung_erfolgreich__153_gui\" bpmnElement=\"reviewSuccessful_gw\" isHorizontal=\"true\" isMarkerVisible=\"true\">\n        <omgdc:Bounds height=\"40.0\" width=\"40.0\" x=\"693.0\" y=\"72.0\"/>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"22.0\" width=\"114.0\" x=\"656.0\" y=\"117.0\"/>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"endEvent_165_gui\" bpmnElement=\"invoiceNotProcessed\" isHorizontal=\"true\">\n        <omgdc:Bounds height=\"28.0\" width=\"28.0\" x=\"912.0\" y=\"78.0\"/>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"22.0\" width=\"131.0\" x=\"861.0\" y=\"111.0\"/>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"zberweisung_vorbereiten_169_gui\" bpmnElement=\"prepareBankTransfer\" isHorizontal=\"true\">\n        <omgdc:Bounds height=\"80.0\" width=\"100.0\" x=\"638.0\" y=\"383.0\"/>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Rechnungseingang_abgearbeitet_174_gui\" bpmnElement=\"invoiceProcessed\" isHorizontal=\"true\">\n        <omgdc:Bounds height=\"28.0\" width=\"28.0\" x=\"929.0\" y=\"409.0\"/>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"22.0\" width=\"109.0\" x=\"889.0\" y=\"442.0\"/>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"DataStoreReference_1_gui\" bpmnElement=\"DataStoreReference_1\" isHorizontal=\"true\">\n        <omgdc:Bounds height=\"61.0\" width=\"63.0\" x=\"574.0\" y=\"516.0\"/>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"22.0\" width=\"176.0\" x=\"517.0\" y=\"582.0\"/>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNEdge id=\"Nein_182_gui\" bpmnElement=\"invoiceNotApproved\" sourceElement=\"Freigabe_erfolgt__131_gui\" targetElement=\"Rechnung_kl_ren_148_gui\">\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"508.0\" y=\"244.0\"/>\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"508.0\" y=\"92.0\"/>\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"548.0\" y=\"92.0\"/>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"26.0\" width=\"24.0\" x=\"480.0\" y=\"216.0\"/>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"sequenceFlow_180_gui\" bpmnElement=\"sequenceFlow_180\" sourceElement=\"Rechnung_freigeben_125_gui\" targetElement=\"Freigabe_erfolgt__131_gui\">\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"453.0\" y=\"264.0\"/>\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"488.0\" y=\"264.0\"/>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"0.0\" width=\"0.0\" x=\"471.0\" y=\"264.0\"/>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"sequenceFlow_183_gui\" bpmnElement=\"sequenceFlow_183\" sourceElement=\"Rechnung_kl_ren_148_gui\" targetElement=\"Kl_rung_erfolgreich__153_gui\">\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"648.0\" y=\"92.0\"/>\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"693.0\" y=\"92.0\"/>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"0.0\" width=\"0.0\" x=\"671.0\" y=\"92.0\"/>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"sequenceFlow_178_gui\" bpmnElement=\"sequenceFlow_178\" sourceElement=\"Freigebenden_zuordnen_143_gui\" targetElement=\"Rechnung_freigeben_125_gui\">\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"280.0\" y=\"92.0\"/>\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"310.0\" y=\"92.0\"/>\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"310.0\" y=\"264.0\"/>\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"353.0\" y=\"264.0\"/>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"0.0\" width=\"0.0\" x=\"310.0\" y=\"185.0\"/>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Association_1_gui\" bpmnElement=\"Association_1\" sourceElement=\"DataStoreReference_1_gui\" targetElement=\"zberweisung_vorbereiten_169_gui\">\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"625.0\" y=\"516.0\"/>\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"661.0\" y=\"463.0\"/>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Ja_181_gui\" bpmnElement=\"invoiceApproved\" sourceElement=\"Freigabe_erfolgt__131_gui\" targetElement=\"zberweisung_vorbereiten_169_gui\">\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"528.0\" y=\"264.0\"/>\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"587.0\" y=\"264.0\"/>\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"587.0\" y=\"423.0\"/>\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"638.0\" y=\"423.0\"/>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"26.0\" width=\"32.0\" x=\"540.0\" y=\"237.0\"/>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"nein_185_gui\" bpmnElement=\"reviewNotSuccessful\" sourceElement=\"Kl_rung_erfolgreich__153_gui\" targetElement=\"endEvent_165_gui\">\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"733.0\" y=\"92.0\"/>\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"912.0\" y=\"92.0\"/>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"26.0\" width=\"24.0\" x=\"744.0\" y=\"91.0\"/>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"ja_186_gui\" bpmnElement=\"reviewSuccessful\" sourceElement=\"Kl_rung_erfolgreich__153_gui\" targetElement=\"Rechnung_freigeben_125_gui\">\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"713.0\" y=\"72.0\"/>\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"713.0\" y=\"35.0\"/>\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"403.0\" y=\"35.0\"/>\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"403.0\" y=\"224.0\"/>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"26.0\" width=\"32.0\" x=\"720.0\" y=\"36.0\"/>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"BPMNEdge_SequenceFlow_1\" bpmnElement=\"SequenceFlow_2\" sourceElement=\"zberweisung_vorbereiten_169_gui\" targetElement=\"_BPMNShape_ServiceTask_2\">\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"738.0\" y=\"423.0\"/>\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"780.0\" y=\"423.0\"/>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"6.0\" width=\"6.0\" x=\"745.0\" y=\"423.0\"/>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNShape id=\"_BPMNShape_StartEvent_3\" bpmnElement=\"StartEvent_1\">\n        <omgdc:Bounds height=\"28.0\" width=\"28.0\" x=\"96.0\" y=\"78.0\"/>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"22.0\" width=\"96.0\" x=\"62.0\" y=\"111.0\"/>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNEdge id=\"BPMNEdge_SequenceFlow_2\" bpmnElement=\"SequenceFlow_1\" sourceElement=\"_BPMNShape_StartEvent_3\" targetElement=\"Freigebenden_zuordnen_143_gui\">\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"124.0\" y=\"92.0\"/>\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"180.0\" y=\"92.0\"/>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNShape id=\"_BPMNShape_ServiceTask_2\" bpmnElement=\"ServiceTask_1\">\n        <omgdc:Bounds height=\"80.0\" width=\"100.0\" x=\"780.0\" y=\"383.0\"/>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNEdge id=\"BPMNEdge_SequenceFlow_3\" bpmnElement=\"SequenceFlow_3\" sourceElement=\"_BPMNShape_ServiceTask_2\" targetElement=\"Rechnungseingang_abgearbeitet_174_gui\">\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"880.0\" y=\"423.0\"/>\n        <omgdi:waypoint xsi:type=\"omgdc:Point\" x=\"929.0\" y=\"423.0\"/>\n        <bpmndi:BPMNLabel>\n          <omgdc:Bounds height=\"6.0\" width=\"6.0\" x=\"913.0\" y=\"423.0\"/>\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n    </bpmndi:BPMNPlane>\n  </bpmndi:BPMNDiagram>\n</definitions>',	0),
('afdf7c20-8f8c-11e4-a486-0a0027000000',	1,	'invoice.png',	'afdf7c1e-8f8c-11e4-a486-0a0027000000',	'�PNG\r\n\Z\n\0\0\0\rIHDR\0\0�\0\0�\0\0\0\r}k�\0\0��IDATx���w\\S��?�� QT�E�j��{T+nmU���]�{;��uW�m�r��r����ԁZ7n\'����&	#d����$Gb�������<����|��|�~�,��\0\0\0\0\0\0���\0\0\0\0\0\0\0P�6\0\0\0\0\0\0ACl\0\0\0\0\04�6\0\0\0\0\0\0A+�$\0\0\0\0\0 f��\n�+�ئ���\0\0\0\0\0h�mDBl\0\0\0\0 b��\0\0\0\0\0ȁ�F$�6\0\0\0\0\0r �	�\r\0\0\0\0��mDBl\0\0\0\0 b��\0\0\0\0\0ȁ�F$�6\0\0\0\0\0r �	�\r\0\0\0\0��mDBl\0\0\0\0 b��\0\0\0\0\0ȁ�F$Nc�\0\0\0\0\0�	��H�m\0\0\0\0\0�@l#b\0\0\0\0\09ۈ��\0\0\0\0@�6\"!�\0\0\0\0���H�m\0\0\0\0\0�@l#b\0\0\0\0\09ۈ��\0\0\0\0@�6\"!�\0\0\0\0���H�m\0\0\0\0\0�@l#b\0\0\0\0\09ۈ��\0\0\0\0@�6\"!�\0\0\0\0���H�m\0\0\0\0\0�@l#b\0\0\0\0\09ۈ��\0\0\0\0@�6\"!�\0\0\0\0���H�m\0\0\0\0\0�@l#b\0\0\0\0\09ۈ���ׁ�4g\0\0\0\0\0�!�	�\r\0\0\0\0��mDBl\0\0\0\0 b��\0�d�^�paHH�\0��� 	\0�؀2�Ƶz���/����S�6q\Z�t\0\0���I�[�Zf�ĉT~�{�\0���D�m\0@�j\n\nr3���\'�7 �Lnn.�� z�\r�ڸ�M���hԟ��\0���F$�6\0 Ǯ]������7<<����E�7}�t��%���#�6\"!�\0!�2��err2ߋPQ����-�\r�/�mDBl\0P\"�5��E��^��n�ĉ�>7-	��6\"!�\0	�/��O����\0��IR?�^����H�m\0 z���(Ŵ|׮]|/@���F$�6\0=___j��5H\0��B�ĉ�^�Z��H�m\0 n���8�@��m��\0�Cl#b\0�}�dHH�\0���I���dޡ	\r����5���\Zڡр�4�N�sj�[]��J$u�:���x�����_>����Q\"qj���5���v\0\"��F$�6\07��u�W��{A\0��������迚��-��e���ڹ�=C�N�>�q�>cҊ�Yg׎�p�-5{�(��ޟ^�-I?�I[���\'���N\0D��H��m�I;ã�������o�Ql��\r\0��;D���/<���.���5����|=FGfi��7�t���t!����/�9��p3z���s����X��`W@E�mD�?��2.�������M���e�k�O����9��\0 28y@�bccY_���Ҽ�.���d���4y�@�a��6�r�ͻX�wq��1�Zԣ����κ�8J��6\"��4�{\'?ר�ԁz���~�.�>}�0.\0P)�6\0��$���זtl���]�j>)VFMP�|�����W����ř����\'�>�����ݣkF����GI<��H�Ƕ\'�Gg��4����\0�@l,:��ztɭ�A.�~MZO=Y`����!������ӕ�������m���k�I=�n���h�����e���J\00��F$��6�N[x7f��/̟7��\'n�� \0UBl���\\K�P��zJ$>�Ι>��YG����i< �i��?]�iu�w~�֯�������!��}��^� V�mDLl�d��&q��7d��W�<S�U\0qBl2K�Pm��qM:|�����b��dƶ���s����E��W�F�e��G7>�K��xR-b���T�0�,���=����\\���g\05$Al#�`b�<vb�Qp՝�rӧO�j������\r0ٹs���oxx8���vaY��`<�1�	�-���̶I�!�.*p]H��Bl#�`b�Vvrn����w�~v�L^�P�U��j���UV`ݹs\'!!���F��2�s��|����M�0��A�x�-�{�mDLl���r�����㪃Cu��Q��P*�/�����֭{��U�+A�*Q(CQ(FO� c<�\n�=�6\"	&�i\nғo���^������\Z?~|�:u�Oe��+�A��1�b���%�6�P\0�!�I0�M���o��i���EF��?�_o�9&��{C��,��2�Cz��a�+AA��1�b���%�6�P\0�!���ئ��6��э$����_�I�ޝ[ԕH�M�v���\'��ƴi�֮]{�С3F<p�����XT����袐��\0�`<a����-�{�mDLl���Z���R���o��t�����A�������Pƾ�e˖��̴2���\Z��N]H,P�pE�a<a����-�{�mDLl�����>�^�`���>8UHM�z�㻱\n�:8T��o����qqqt�����p�B;�A��1�b���%�6�P\0�!�I0�M��_?�����W���Y�I�����2�:8T�\\ߐ�dK�,�:u�\\.�ˬ����~�i���QQQ��;r(CQ(FOX\"�oc�b�������5q�_r5��\'�긴j�.�?8<U�Q��j��������l�Z����a����w�^����ş}�Y���P�pE�a<a����-�{�mDNl�h)7������e_���&Ǚmb�۷oW(�F��ߏ3s��5�RIMW�T�6m�S_8(CQ(FOX\"�oc�b�۔�wED?P?���9�~���J{wl`�����QQQ9fr�e��c��\\n��$d(P8��P�0��D@��\n�=�6\"��ԙcDE����͆��e�{�O�EJ@ ��q݈*�233ә<4�~9p�\0�������@��B1�x�}[(\0�ۈ�l�f���\\��R����e\Z�����q S�q?�J�ʬ۷o����_�^&��Tp�֭˗/S�>|ep\0E�a<a����-�{�mD�?�=�86�ͥ	�\\ug��7nܸq��y��Z�`AJJ��\n��������]�v���(#�\',з��p��H��m��>��@�����!j\r�t��ׯ?~�ʕ+s�̡J�+����ݻ�����~�����>(P8��P�0��D@��\n�=�6\"	\'��d�WO>�DA�Ͱ\r�|��f����A�Y���y���[�n��d���0~���@��B1�x�}[(\0�ۈ$�ئ��,���������ȻA���㷽���\\IR0LeT\r\n�P������B���F$��6پ��ݝ�W^�߶���2���=#�G�ŕ$eK(P8��P�0��D@��\n�=�6\"	&�)b�l�����חtp����Z_r��N��Qp���:(�XB��1�b���%�m\0�b��t�#�8{��J\\�E�W\\��%7�Vӎ�t\\up��,�Pfq�M�0��D@����		�~�� \0�b��(�����=�v�N�����-��8���γe����M%��SO(�(DJn-�vߐ��Y=S�e��,qAl���Mv0���\r|^�hkb�e[����Nuw}����K���I�}�Jkؼyspp0�\0gۈ$�ئS)��T*E^nyy\n��	�y��͊i���1>��������o��\\h]c�e���Y���&F��A�A�ʍ�s�v��Q��Ko(-��l2��.��p�Dݷ��v��E��~\"�p��H�m���u��\Z,�(82��n�3+���7�o���R��@�nk�J�LV��壾>\r%�&]�Zs._[�D���KR����@\"�۴��gn�v�������tꐎ>��]<��XwI��P�0/���7������ϯ�����ڙ��d��P?�~u�4zi͍��%c��Po��ot�����ݣ]��wXFϷ��T�F�����&��귺xՕH��uzm��l�3�{�%F�mb�ۆ��3���kP]�!{��*lwj�-����R�)�	_����d��%�}�]����:�x����/m{�̗?f�MYqD�eV2>�3ʍ$*��N���� /G�\"�v6O��֞�J�}�<�ѐ�\08��F$�6]qfZZVaaf���R3���M0��Y%7�l����:5<�a��g���s��rk����%ڒ􃟴u��}��y���)IZۻ~��?^�U�_	�[\"�1ƶ�Iǹ�3�T����s������*Y�����Gg֑�~�{���`�x5��D�~������s+{I݇�8��X�qz�(O��K�gz��k�!c�(������}9Zu�����Y�V��:�v����m��f�u�%R�mbT]l+�8�t@���{���l�-�4�0=%��,���wfiuE�g��bR��W�:���{���x�ك��mG��W�8�(L�t?bpC�AK�?,.Ɉ���=������/�H�v�̆��%�6\"	 �1�>��@��cw���w�������\'�#ʴ������;��Ժܨ7<=^ߛc�׊؉^�Ͻ\Zq(�a�VK\'nƉ�$C�1�8�;�z���ЫZ� ��s��d7����i�m����?�I�~_�~�-C��o�����@k|����ݤ�V^��41>�����D��������zr.����.��-��s�o�W������&4i61V�פn����ə\"���+�9��x\'�4�g\Z\n���&F�W��¹mέ����a�g��Re�P��R���[\'��l�V�\\��4�wܧ=�{mLU=�u�{w�募�N1Ķ�����\nÈTP�ՙG�K��ER=��+���R�񟺢�����Q2�5M�\r%�e6$7�]��eXPPy��mDNl��ί�0|Ɖ���a\Z>���7CS�s�\Z|}}���&M��y��3ԟcƌ1�����ȓ5����w�wG\'���_�n�g�y����g��֢5ͳ�;�..�4������D:dOّ������c��WD:���v\r����S�/U`x��?y`�߃�->=q�i����Ҿ;2�E,����l1���Q\r�&-(>?��}TdVξW=}>9]HU��)$o��g.�fe�P��61b�m\r�m�|���k\'�~������g��A�y��T\\q5�-��O�>:ɻ��qI�_�����<^ޝ9ʫ�ʤ��*�F����<���ӋTtm����7�>��V�[�����̆�vEZTN+�M=��oT��{I���H��m�[˂\\_���^ީ���[{>~�k-�]QV�$�Q�:�g�٨䦩��\\\'�*z\rj�>�Q�wv�,;��v��6���Wj��>|.��Nڂ�ckF�����n	�DuYiUt���f{�ҷ�(m�\"�U�t�����teTB��9h]�U������K&��T���9,/+���k;;�[H�����:z�ܴy�G����������󋯕Џ�)���~�(�f��ӆ� ��Sl�7|��ȣ͊z�����Mw\r[%�vGm��Ч{�*y�����f|;�;xGz��9�y�����_�()�|�Ƕ���<�<����ٴ�M���f���ɕ��JJ�L�MW$7�-*�Qy��^܌�Nntx#��!����VZ����ݝWZ?�mÁ�e�Je{Gx��\'��I�:r�HPPPdd$���͝8q\"����|���\Zt�p���Z��k?���<���{�9�6��z��r�@�S��cBS��;�U�&j�J+��֪�f�m����]�1��D�S}lSW��ʛ��PZ��㦢$�ܚ��.~N)d�h��T�V��z�v:��$���1^N�K�\Z˰��]\\\\���&]V�S6l�6l���mq���������\n���uU�П�|/X���Fy����z/�I,�d��3m�������r��qu�ߠ˪�j�\"�O��N�/*~?�\"�1�:�H�([$Mj���n�W��R�2�-���r�	E�oͬ��{]�E}���l��M�� (T%F3n\nl�&Mڹs���O�V��ܹ�yro=�b��\nOh����E7������M���םZ�{���n�˗/���V}�-[�PO����;�]f-j��z��gY���Ч���m\n���_K)�@�F�\r��\'�𥳒a����~��k�K-���6���)�;��<^^ulS^�b�^���c��\'�n� �4�Y��1V]\'>������s5,�{�����Te������ۺdӉ/��cK�w���$ql�c�ϗ���6^!��Qu��Rxqa�:�ݗ^+f���P����)����ד�6���e�\ZQO�j��g���a|`I�)+������N�9A�cR�D,}��̆��BT�a�\nlw�ܩ���EuT�ǋ�c��H��mz��[9{�r����_��Kn���������6r777+2�JnAAA|�	���XUz\\̹����Ǯ��֕�4�E�-���h?b)����&F�:��G����e6$7�9��?�_�?Y�a�����Kd�Cl#�`bE�������K���^~\"C�I׶�����Y��d2q��I�&��>,c�2����>Ү�Of��E)Om��a!��J@l������%��튙-++�����aHn`5�H,�2ݔܨ9�����>l��HB�mO��2��+4v��5A}��$�Qrss�!�ȑ#|�إ�����>hH\"�����Ģ�ݩ��Bl#�6�޷��E} ^�tɴ��N������U��r�������1�c-�������m�Oq�cl �I8�M/����\'U�k�n\0�/S�Q��\0��S�w\rceѢE���eK/�ȃ�&FOXr߮��?(SEr�3�z\n=�\r,E\'.Jhh�u��ĉ�9P}��wcc�mDLlS\'-�o\0��Q���]H��zK�EWK����DFF���XDQ(�Xr�E$�61�x`�v��F�:��g6����Br�LW\"qss�����d�����ߓ-!�I0�M$7\0�4iRXX��>�CBB\"\"\"x|;NNN������_�<X�ՃР�8��&O���\re�*3WYf�6�U�ِ���9c�ӥ#kR�Q���U���\rr	��H��m\"�����ݻwk2@��>��=NRb&00p�ʕU|X��b	\r�1�6��xbvm(�V�Iՙ���V1�U��hHn��E�t1���ؚTb�-\"�8I�6\"	&���\0�=��\Zk�&$L�4i2w�܊G��b	\r�1�6��xb�ŶjW��llnua���3[���P�Gr��,Ch5���@,�J�q\0�~�9rĴw^l��	fi��������z�O�A���+R����e0�p϶m^��d6�yrc��h�ɍ���f��E�*1z>b��n$�m$b�mV��Y5�6-}ar�������z�Uj>@��>�L{�E����`6i�I�&EFF��V��Ӷ�\"��j�;��o�������\Z�\ntf��:�咛E�s��l\n�@�,ۢ��=�6>��6}qJ�O3F>WO\"��b��K���ؖ��\0a���������رݻw�G1��۾w�Y�PT%t��g�.��[�0!6l��\r�e�7LC�	��L]���c<��6�E��Ԫc͏����d�DK��,Cl�p�$�pb�^y�ئ٣�w�ؠ��MGR�v^�UR߻wP��pb�$Æ\r��G�w���%G��R���W�O&ӪA�R5�6���5��\Z���Z��0��g���UF���L&c�W� Ijb�O����VY�!MG԰*ۺu+b��\0b��$�d�g!~\r$��}���G5�����Nk3��j��\0an���k֬���P+e�Q�V����f��oRQf�d��2�����\n�m5G�Dt3R���;x1�؃�c�Uf�2��g�#��\r��ֲ�CR�=jհ*;v,=�\0\0�O\0�M���~��Cw\nuԟG�n!��F}�P#EMsԨ���%���f̘��t�Y,ٶ���-��v�8Z�2�m5d�kmhhhM������د2s�&�r����&�!��fuH��&��1((��2��o��{��6�\0b���֏�:I\Z����ctr�a!�6�t��yZddd�6m�};}4Ro����6�y�E1�\'���2Ķ���4�D�I�&�pVO���}�&騊�Ƙ�hU\'7d�Z΢UO�]�&mݺ��UfΜIρ�둔\"�J\0��H_x���9!�\ZI�H$-��u۸�M���f����\r���F\r4|���b��e��Dďj�b[M�gQR%ǻs1��$��͘ܪ�l�ʒ2X*44���FIHH����b��f�g�Cl#�Pb[U��ߖL�ӌzt��?�3Ee��m���__�{���$��Y���]m�B�Œ=�,�Pɚ�!b[M�� ��d�x��6���r9�і��d��*�4On�S�)�l��T�����>uh�V��]<��\\_�/-�f�|5.��՚�~c��Pc�w<����\n\n2�C����6\'|��Cl#��b�Z���k?���(��������Y4@T,��|�ˠ�b�e}�b���|�@l�\Z}VU�p��OX~�.���HVEf��0[e�Rcl�(�t�,6[Ke����r������^R�+�2JTYg׎�t������kDFF���u��E�P�Ǐ7e6�\"��\"�I��M�BCC�樴֦M�e�R�Y�٩��\' ��RC�mV�������OXE�.��N�>��L�a6�l�tls���}z|���m?�xm����ION�פ��R��«%6yA�ߌ3Lɍ�����Su�v�Z�R?Uۈ��f���77��Ǐ��l۶m��j��{٭�2�%;uu�8I®Pl�mV���]�HZ�	Kb����K��l�tl���xH���k����3Ǧ6��c:vG~`TC�I�\nm���?�-LL��fΜ���`��\nU�-^�����C�G����F$Nc���u�V*�M�<����U6j�8p 5^P��{��D�\Z�;5}Kбc��c��F����DW0���ܿ4VK\"j(�#Y����f���N��O�kk����l7�\\����)`�m\r���u���/��������Hz@����H���}�Al#b[M�d���Pj 7nܶm�RSS�ۓ�s�ڵT`�ҥ˒%K��?����m�N\ru��Q�x6{�\\�۬�c�a��$����`������cl��1Ƕ���U=���9��V�^�>��)���Hm�1�cU�6�:�|/��!�IP�M�s�����1&G�s�\\tj;vl����sʔ)����l4qU<Bl�b��ۄOt\r�&��)�=�$��<�f�:�ߕjL���Ehl��  T�5y��r;ߨz�*ҨR��z�\r�6\"	&���c?ioذ�::�x�9�ઃCuDW=���c�mVCl>16T���~�\r\0Lۈ$��Vph\\˾a7�K���`)j\rZt�y�e�2����j��6��Tqi߮,�!�p��H��mE�������\\ug��,��8�f�\Zb����oWLn�l\0�Al#�`b�#��e�_��!����7�ܼ_���C�Pf����14��ۄO�}�NnTuA�Df�b��J�\'?t�������A��b��,VCl>��m:����\"�p	��H��m1�[v]t4�P�5�én2�%�6��Y���&|�m*��,\0�Al#�`b[a��]>8Y�Uwˡ�b	��ch�!�	�6\0X��H��m����z/�y�~�����R�U��j��b	��ch�!�	�6\0X��H��m�c�˟نs�eK�mC�X\r�M�з�\n�mDLl�g�$���Q�+I\n�,��8�f�\Zb���o�ۈ$����Qi᭨\r˾ZJ[���O��$��&(�XBl���j�m�\r @���[yZ���*�mDLl�g�oL#�kǮ�ׯӤs��-�J�ݦm��檃W���}�c�	%5�����\0i�M�}���X@l���j��6��Tq@���*��Y��o�\nz�b��\nb^o�$���\'��vd�5)�c�>���x\0�\r%����wǦ(m�P<B��b��,VCl>�m �k����x ����Gz��x�O��b�OSS����Q7\n��D��m�{�ӆ��j����������Ǹ6�x��~p��i-\Z��+K�H�u��qnu�7��?fqt��� ]���oy9J$u�:�����p��>�L��]��\Z\'���T� ��C��b��,VCl>�m �`j-�W/,}T��J�m\Zd��^���7��@I�6\"	&���~����C���S��}��D��AD�f�Pp��+zv(��H����Q[��w���mMϏ~����h��.�Mi��zT~����^R�+Og����֎�t���fQ�P�K�6����e�2U�죟:��W�{��ˍ�	�M/Q�^X�����B<�eK�mC�X\r�M�з�p���_]��Bj�m�&�=Ҧ�x��c�W�sO��u��ϹK��H�1��J�:���1�#��~���{EUt���Q��#y�[M�M:Z�H��<�^��$͓Y���R������P�y����ͼx�P�Re����y��M=�Z��ܓ���k��;������,��8�f�\Zb���o�Sk1���kL/t-�\r�!��F��K|XR�H�v4b��kv�(��̶\nC����z��l�\0�qz��9m�G�����g���-~���̴��!{Mw�S��kR�z(Q�X�����g#�*����r�/���Q޶�2�%�6��Y���&|��@8��ZL�~���Fl~)��W���/�����c������m���C�<Fn�2ʣ��	*�_�[K��V�.�b����N�]6}����\rУ�Kk�8�0�Ǯ���xr��RUN򝇅��ن2�-�6��Y���&|��������m��ũۓ,�n��+*��ٮ֊�Y�����2�е���\"���T7��l���_�M�����ĽH�O��	�J��\r%�Ѫ..���~�H��U=���9��V�^�>��)����O�����m��s9\ZM���.>�*���4��۰�2���{{>i_�������ʠ�b	��ch�!�	�}��m\r�\r�߃B#E~�����W��e�ݠ��+*��	��b|��R���]��OW2\n{E�62	&��}���J�#ŁQ>�(i��\n��pD0W�dJ��o�� ����i��f�:�ߕz��!�<�<su���ߌ����u҆����������@Mul�cʆ~���,��8�f�\Zb���߷��m�~�٤���u��3N�pu>].���TO?+<Eyma{i�-�=q�G�s�4�j��4�ٹ���/�x(ȋ+���֪��^�Qi���R��͜��;��	�6\"q\Z�W�����C��Q��b���Ǐe�~�@AUO.��b���^�U`�����j<6����ۅц��(�[��<��CЊ[�Ǐ�鿾ܸA��#U���\rW��%=?�p���3����; {��������t=�S�^�Ӧ��ȼG�U���Rq�������M�]�ny�����b�۴�Wvq���y�ܰ���By}�K�]V��r���:XBl���j��6��Tq��oS��ܹmξ�f�uWM�O�`s/���J自\rW����A���TV{��1\\��X!�!�$�i�r;�c��o)�&-�������{o~���}�{���x{�\0��1�H��m�)���^O���YWR�M��Ǡ�\'��uo��\0��8�f�\Zb���߷\r{��oN�{7�Ʃ��{x�ze�9���f�:�Je��ߞ���K�)?�mJ������w��;��Z������/�}g�(���w��-�0�I\0�� �M����ߧi�/����/���u��Ps���:�\Z,((ज़�ȕ+W�t�b�U�\r\'<h���0�Tˮ�	[�$Y�{�I�[���>��n�4\Z=R��M�(�?~�����c��p����榽m�<� ����3���k����v-^]�J�N�$jxx�\0���F$�6Ş�.�V�5�^�d	*��\r8p֬YvZ�\'��,V���0��a�������=*<����z��%Q�Jw���|+OejJU���W�+|lHi��\Z.����[t�2��V�S����:�o�5,Y���ػ�I�翼��o���F$�6`K.��;���-��)S��o�/a�����j<6�6�:��U>�Q���q������c}މ�o=�:_�)\n�O���A����\'���b[eOy��sx=���xj���\"Gԓ��sI��� ���Dmu��t�׿�៝.涛]�����f�\Z�\0�H�mDFlsr����O*���u�~�f�͢UJ3\"zI��%a/$���f�f�\Z�\0�2\")�ۈ$��F�A����b\"��+���\"�K(��Y���\0��H�3�6\"!�=Csc��g��>�(i4`]R��5ow��+��q|}ũ|���9ǖ�����8�͵��A.�Ux䓽m���qm2�h!����Z4\Z���R��P��\Z9w�o}�Ĺ��\'�s��\0\\B���b54\0���w�������~�t2\'2US�$�����Nnu�1��̒�L�Y�lK�ǚ�ߧ�ت!�@��]�^w��p>%�DR�3�6\"	 �����O�dX{0�MQc�������e�K�����\r��y���]X�����_�5�i�:x��,�6���/8��W�O���#UeI*b���z+�x:wѱ)�<^? {���۫�;7~�@#����&�����lFh���\0@���\'����g�V��<��=����d�/��-u��t�Z�sn�hO�n�KX�dy�G��|�`���63���\\��tO�X�4�����H�mBb�m��\r����^N-�s��Q��k��;��x>�Eiㅮ(�J�.����fz���[e�������kTV{��y�I�I�\n�g�ӱ���W=���KY۹�����lFh���\0@���_�w�C�6����ݥ��o^1�d��+�uZq�II���}�z����ȶ$K�����n��m1W�T����N��U�HNy��F$Ķgb���_���W��y��cn?���vp����3����5�%IT��q�\'7��k���sVY�Sfl|����H���� �q��\"���jh:\0*�u�\Z��|�Ǌ���-���h*ɔg�5��g�\rE��Q\r���y>ے,^���:;�{�zԟ���������Ҋ�)�ۈ���:�����pϙ��9w��}��ǏԹw�3\nl��l�j�qѥuV�f�0<�Hev%I���~#����h�y��桌3��^c��>mCwg��\\B���b54ˣ�sK��R����M��N�}Fk�|1��F�ܠ������u��1}�����4z�k��s��}ҕ��;i����� �R�9��2f˒����٣�uTR+�b����~��)f��&�<Cl#b�3�>��o��m��S��R���������q���C\Z�\r;�����X�����SE���7������.��뿰�=0>Ev��F^��$������b8x\Z��\"���jh:U��6�/,=����~���g����}�\r^q*K�ɽ������_Fp/�ܶ���z�H�a�Hw�����f%�����R�W֞��h�.������וlK��7���z��H,.}����[M]���Mc�XJLy��F$Ķg�ǶǏ�y\'����`���Y�)\n\r{�r�};�ߕ����m�ƫE����}����8H���+{)����z��\r%���^��i����\\B���b54]��t�g>�^���z}���������95l����%).�Xx���\'SM����|��5L�d�m�����ӄ��\Z���:6[_�$�eF/CW_��BL7�GlK����??��#5<�Q����=0<�q\")�b��\0DE6#4���t��e�c���z}v����涮?h��&�%)~��B}��	ޮ7��1�K�A���e��� �@l#b�h��f�f�\Z��6c��cXJL�V�z}���5�����QQ���������3�6�Cl#b�h��f�f�\Z��Vc��^���0���%|U�z}�kx�*b�$b����.\r:}�P�E{�!��b��\0DE6#4���t�X)�e�t��_wt����Y���tt4�mc��r&��*�������ư$b[I��!�������\0D��H�m\0��\"���jh�ZL�x�G��6���̽�e��D`8���z}z;\\��<�1.I��m���u<C�׆\0�b��\0DE6#4���t�\Z�e��77O���,��t|���#��`��$���l?��Ƹ$�c�b��:u�\0O!�	�\r@4Pd3B�X\rM\0@$�6\"q\Z��\0j�.��^\n�A�X\rM\0@$�6\"!���lFh���\0\0���F$�6\0�@���b54\0\0�ۈ������\0��Pd3B�X\rM\0@$�6\"!���lFh���\0\0���F$�6\0�@���b54\0\0�ۈ�� \Z(��Y���\0 b��\0DE6#4���t\0\0DBl#b�h��f�f�\Z�\0�H�mDBl\rٌ�,VC�\0	��H�m\0��\"���jh:\0\0\"!�	�\r@4Pd3B�X\rM\0@$�6\"!���lFh���\0\0���F$�6\0�@���b54\0\0�ۈ�� \Z(��Y���\0 b��\0DE6#4���t\0\0DBl#b�h��f�f�\Z�\0�H�mDBl\rٌ�,VC�\0	��H�m\0��\"���jh:\0\0\"!�	�\r@4Pd3B�X\rM\0@$�6\"!���lFh���\0\0���F$�6\0�@���b54\0\0�ۈ�� \Z(��Y���\0 b�8�m��C\0b�E6�K!8h���\0\0����H�m\0��\"���jh:\0\0\"al\'b�h��f�f�\Z�\0�Hۉ�� \Z(��Y���\0 �v\"!���lFh���\0\0����H�m\0��\"���jh:\0\0\"al\'b�h��f�f�\Z�\0�Hۉ�� \Z(��Y���\0 �v\"!���lFh���\0\0����H�m\0��\"���jh:\0\0\"al\'��\r\0\0\0\0\0썗\\v�il�\0@\r�1�K!8h���\0\0���F$�6\0�@���b54\0\0�ۈ�� \Z(��Y���\0 b��\0DE6#4���t\0\0DBl#b�h��f�f�\Z�\0�H�mDBl\rٌ�,VC�\0	��H�m\0��\"���jh:\0\0\"!�	�\r@4Pd3B�X\rM\0@$�6\"!���lFh���\0\0���F$�6\0�@���b54\0\0�ۈ�il�@\r�E6�K!8h���\0\0���F$�6\0�@���b54\0\0�ۈ�� \Z(��Y���\0 b��\0DE6#4���t\0\0DBl#b�h��f�f�\Z�\0�H�mD�0�)o~�~:A�sj��-7��m\0v�\"���jh:\0\0\"!��mlSg^�9��/;7�bw����c<]^�\'Cl�;ٌ�,VC�\0	��Hlc�6k���\Z՗:Pp��/���ݧό�Z�6\0�C���b54\0\0�ۈd�A��c3�\\�P\\}HCl�9ٌ�,VC�\0	��H�_�D� f��#��k��ӡ��Y��h�\0��\"���jh:\0\0\"!���ئ�����5`��5[~�5���ɽܤ�C/!���lFh���\0\0���F$K��y��{Q9:ӄ�K_tl1�Xb�ݡ�f�f�\Z�\0�H�mD�0�������f���e�9���Cr�6\0�C���b54\0\0�ۈd�A���>\n�7g��<ý�Tٗ\"&��}�&SUq���\ZB���b54\0\0�ۈdal��3���r����m\0��\"���jh:\0\0\"!���ئ-L�{�Rw�+����\ZB���b54\0\0�ۈ�:��T����J��[^�B�c~b�\r��6�x�b���a���(\0\0\"!��ulˏ�Sg�ֈ`��Dl��朜�*Fcǎ\r		�{�D=\n\0�H�mDb���83--��03�~y�����`(�ͽ���c�����-[�^4�@�\0 b�,<�����o��z�����G_�}����\n�\r�\r��Pd�۾}{��֪U+!i�(\0\0\"!��!��V���Ҟ\r=�N�;���+{�L��6�����IFԜu\0Pt���RH��6t�Р� �JLУ\0\0���F$c[ѩ�}�&(K�Q�|FE�K�wVyO�-@l�;��>s�mp��ի�^(1A�\0 b�,�m��#�ݝWj�m�y��y��_��`w(��Y�|�)����Q?����^(1A�\0 b�,�m��A9\'��o�m��ka�=�V$��\0�Ev9�����6p�@___��HdУ\0\0���F$K�m��N}ѭ���ݳ��~�6�%�����U���\0j\nEvE^^^��6}�t�GdУ\0\0���F$Kc�q�[慝?|���ϗ���tz	�Ȇ�`(�+�3g�� ɋ/��8\"�\0@$�6\"Y��%igb.�jKK5��8��Bl��슒��M���e�(\0\0\"!���\0�X��ԡ㼋���7׌���:lC2�S��\0j\nE6#�Y&N�����z\0\0�ۈd�\r\0N��U�O����ӦW��l���3ňm\0v�\"��,�v��{A�=\n\0�H�mD�0���o642�lJ����#��\0\0��\"���jh:\0\0\"!���ئ��m�g��kE��6}���4	��&���P\0��lFh���\0\0���F$K�m����(����ӳ��T��y��<�\0\0�B(�sss-Z$�J0`����^�����tꐎ>��]<��XwI�����K��ա���ot��tUU3��ދ\n\0\0� ��Ȫ\0d���v�W+6쾐��B��m\05%�\"{���Tf�������\0��;w�������uEP���D�q��L5��\"��r��V|+���}������׌�t��������G\0��!���ئ�\'l�7�_@���c��>kvĵ}5OAl�!�nnn��;w�$$$p�������;w���0�6�N+�J�e��O�v��+���,K���T����k�eBq�3B�\0\0�Cl#��7\0���gCϾS�N���ʞ�=����\'G��n(\0jHE6�\0S�R�|饗�ū[��իW�OJ�B%[{�)Cl��\nO����9@�;/���f����=&?ꕆ^�(�Z���(\0\0�9�6\"Yz�S���/LP�ʣF��������\n��[��`wB(�c�����ԩC/�����IIh��m����s\nX~�lo۝�����\r\0��Al#���M�d����JM��4o�0����\0\0�\'�\"�1��i�����>)	\n���,qe���aqJeֹ�c���\\�<�	�G\0��!���ئNZ����s�����&+���3hE�\Z�\r���PdS��`ڴik׮=t����8p���j^b[�N�~p�h?W����|�?�����{�\0\0�Cl#�����e���V�*<�J��i�X��y��|�\0\0�B(�cۖ-[233�ʄ��k4\Z�����B�\0\0�Cl#�U7\0ȼ���o�������N/a��\0l@E6cl���?����̖���p�B�c������B�\0\0�Cl#�5��Y�����@\r�E6��`Nd2ْ%K�N�*���ؖ����O?-_�<**�6�s�}M�!�\0\06��F$b�^�r`���ތuG�霦�;��u�ƃ\"e�m\0v\'�\"�<����fgg��������������{�R�-..����jmr�}M�!�\0\06��F$ֱM��Ϥ&I�����u���\'��[9�K\"��0:C��`wB(�M�m���\n�������qf�]��T*��*�jӦM��\'�����B�\0\0�Cl#��Vx|r�&���KKN}��3���F�����䱈l,b�*%rmD\\���� >B(��ؖ���c&�Y��;v����|g(����B�\0\0�Cl#��&�3ԭ��4�5#�Q�8K�}y<��%$��6پ��]�OAl���l:�]7��[fff:��F�/�~�;C���5ņz\0\0�b��Ƕ��ƽ\"\Zs�\"f����g��g��c�:��	�}g�q.%[QT\\�D�U�>!٦�v��휜�����d��\nnݺu��e��Ç#�	�z\0\0�b���mM�MT�2������T��U<!�tl�q��������`������������?�/�v�Bl,!�(\0\0�9�6\"Y�\Z�����?)۾����Ͱ_���>�^�\0hҒ�KJ+��6�2B(���|]�~����W�\\�3g��T�w�^���~�-##������5ņz\0\0�b��Ƕ�#\\*�\r3r��&7\0�����{�_@������>kv�U����\r B(�%ewg����7o޼u���L�Q�P�7>���5ņz\0\0�b�j~�m��+�׾��г�:x�����i������Cp(#�\"�۠j��)6�У\0\0��ۈ$��Vx����������Z��/ӫn��~󰂫 xB(��X�}M�!�\0\06��F$��6پ�͇��՛b�>w�0���ɸ��\0�\'�\"��%��\0\0�Z�mDLlS�Z������y��-������A�o����\0���&\"��)6���BBB��\\�`��	\rG�/�>���Zh�F�>�赹q����UW\"�����e\'r������OCG�ĩi��֜���y\0\0�ۈ$�ئ�����[=���g]I}_��������B�\0&��m���7�H�O=��\'1R�]��;�RQ��Trky����T��O�}MU�Jkؼyspp0g�Mq�_�\\���aڕ���s�G�V�����\r�,�yP\\�}n���#����������U:U����u���]57�\0 z�mD�<���	���7^�1����fG\\+��\"��2�����/��x�q�tk\0`l�fE�4i���W����8$ي�b�V~��Θ�B������\Z��.^���j���%��3��t�#]�/�0��c���:M�ƞNޟ�)������sύ�1��{=4�P��b���\0\0�Cl#������R�z��\r�{L4^�qrt>��VM���ww\\Z1>�*%�ئ���#�%����t[�TBOU��ƿQДw��u�޷��Y;S��L�\Z���������F/���\Z�dl�[�5\\�F�J/��=ڵ�{�e�|NN�n4�*jrN�Sw<�\\b4�m�����tꐎ>��]<��XwI�Y�l��@e��M���� /G㋾v6����.	�k�\n晍�arS^��֥�y�4�&o�7LYЦ�}e�ͿT�)|֘n-�Qzv}g�%	\0�b�,�mE����_��,�G��%/U�Y�=!��ƱMqt��D��<��_�\0�.����.�Q�ST������g�-,�m��{zt�!`��׸Ǫ[\nƉWC�K$�gLNON<����}������׌�t���zơ���&�3�V;���k�r����#7��0&�H�uv�H��۞=����F�nǹ�3�T��|�˹_xZ�lKn�U\\\0EYlSߏ��u����K2b�:{O=�`\\�Ƕ�����Vr}Iǆ���Q+�IG��ͽ�:?��Z	��2���2��Ӈ�e��zmAʱ5���v]��$\0�Al#���M��p�ǼRSl+�3\\�q��Ʊ����>���w��8I�!�T ��f����L_�1����T������{s�l��o������>5Us��n�N+�_e����i��pU�e����]�H}w]�z�^�9���ǫ�ru��Y4i61V�g>�.Uc���Cl��ظ0�:��M�7��~Ҷ��+*Ζy.^5Ķ�i�}���]*6�SWt��ٛ9J�%��P�QYf�4���V�x�5i=�T�q�:e���nÖ�H/����q����^��O�1vˍ�Ny��	M]��\0\0ۈdalS\'�r���9Y�~Cl�]���\"Im��VF�|pf۬��Iݡ{��ګ�DX�M���;�V*qpt2�k����{jcR\n�\n9(����I[|z�������}wdPa�0njs鐧[�,jTC��G����u����UO�ONVzL]��R��m�^O*��]���g˼\0ї��Vtm����7<+Y��\r%Ug6��:�Ǟ�����u��>�t|gO�������e�N�L���~-��~�蹡������\0\0,!���s���SO��ئ��z���uէ6v�M��g�̱]�$����<��\0�qss���K�.���\rY���ፚ�����\'nG�j����x%����|��8%7����.�*��xCl��p=xU�w~N˓�vv%����n�jnWu��i�(�v..T�xL���<U}l�8[�x��-���io�^qa��������\\C	�)�U{1�\'7]��qM:|y��\0��6\"Ys\0u慝?|���ϗ���tz	���$�U����Ml+�H܃�����M���|j\r�������0���F�~ߣ^�n�2�[��x����i8��Ż;n*Jrέ��2���BƉ�L��z��R�W�Ng��d�_?��)p�Uc�JZ��ŵq��oo���阺�r��+���l@�D�6�&5|HC����d�T���pi9턂qIL�<��r���Yf6��F=��K�Sܻ�w~��k��8J\0\0���F$�c��$�L��\\*Ui�q2]źU��\'!�T%44�ڎBBBx\\Sl[�ޡ�܋�G&�5�6���<h��k�ttl����M$��~!K�34��Tq�Yl��V��E��\\\rGŹ�Y�?MU6ߟ{;H��K6�|g:�����0[�P��6��Y�_�����u��	\n]UK\"��fif�kr+>?��D�t��˅��\0\0V@l#��7\0���E�C�y���o��S�u؆d6_�V_�h2/{��sM\Z5hԤ݋�.?��a�=j�#G�P�QPP����ؿg�RU	&��f]f��>7\0\0�+�6\"Yz���n���c���I������||��U���ŗ�p�|�����3bŴ����\'(��O�Z��(%%��@lcI��bf���b�LCr\0#�6\"Y�d{�7\Zi�	��g���}�n\0Pտ�@غ�/?���/:�~�TQ�s�=f̘A�6w�!���{l�����/`s�ԩ>���Y���{5$7\0\0qAl#���Mu��@��u׊��m��?i��M��UwG�}#����@�����!@푒�B_O�������ol���?(SEr�3�z\n=�\r\0@\\ۈd��m��#�%R���}zv��J;�=���\0U�[u��@�A?$��L�q�g��o���	@�A�!,22��WGlc���V1����ëNn晍z�����\0\0D��HV�\0 +~xطK�Z�a������@�i�:�N^�rp���������&�63f̠6(777*��|nNNN������_�<��c�Ģ�\re�J1WYf�6�U�ِ�\0\0���H�c�^] ����y���Y\\ɹ�\"F��.�ȥ����M���Ͼ��\\��CT���F%7���ax��	\\�re�9bK5l(�V�Iՙ���VmfCr\0�6\"��m���:um��T)cՁ���|�H��?���m\0lQi-((����6i�$j��dئ%�&M�̝;����X�al�v����v���jgN���f�٪�\n��?�\0��!����6eVZZvQQV���R��5�ۦI��-����8��SP�,��A�\0U�����P��\0O�D	f�jŦ�~��`��Pn���l4���>��̓�o�QPPP�QHHHXX�\0\0 ���D���f�M����<j�G�OdV��\0��V����\\}}}�](��^���k��َ9b��KnjK����M�&M���{\0\0B��F\"Kc��7Ůfκ´۷ʻ�V��m\0v�X�����;�{���\r�~���x��\re�J)���E�c#��%Y>��={�C-ɑ2���ng���	\0�b�,�m5�)v�E�:�p؇#��k�ݪC�q�6��řn\0�g�JwذaT<�~����\'�!��d��V�J���M&�=b!..��A���j�H�_ ��2TT�\"������\0\0v��F$c[\rn�]͜����۹��`m�/�F��xr/7i����U=\0l��6�jՊ��Iddde�)�X�ylc�RLX&7��a�2�	?���M��\0�b�,�m5�)v5s.8�N��r�^ۤ��[N:^X���&���f̘���(�6�j�دs�&�r����&��(��PqWb��*���Z��H���f�M����⟷_�2���}���[����M�\0�YT�Sru�сA\rc[M�Qɍ1�ѪNnb�l4j������\0\0p��H�_I�T_t��7Ů� ɼ>\n�7g��|Å)�9�#&��}x M^`T���\0�\0��%~wK2&�*2���&��Vj<Ս�N�H�\0�\n�mD�0��$��}:��mژ:PU���р��iO��ǝ\0\0�\0��%ޏ&���\\.l���d��W�<�QO��Psof�чJR?�^\0\0� ����VplJ+�ĩM����0�U3g]�Ô�J�<,\0\0\0��%�c[i��FG�*2[Ň��J�w���p�{A\0\08��F$���)��n���~��$�,�o�W{���a��ھ�w������t.O�Iy\0�!��$�����7On�O��:��?��l��~6ЦMj���^\0\0���F$��ƲC����>���DRw�>9�T��\nN�h�\Z���k��m���o\0��d�4\0�	���NC�Kn,���(�\'O��Ț5k�^\0\0. �ɪئɾ�w��q]�$��qs~:��eՁ��wa�;�\'�+5MP���r҉���\0�N\Z8A5��ɍ��Fٺu+�FƎ���\0\0p��H�6U⦏>\'�Hܩ�����r��1V3����_\\xE�tBi�_�[�]��\0���F�Lh\rEe�����;���q�xd*����\'nm��j[[gk�����t��}*���mݥOw��q/�\n���;���E*A�B�r����+��or�˧w����ߋ�Ga�&xyy�\\�j��\0�@�)R�-���IU̵r/���� q�z<������#w�	~?Lvrz{OtJZ�L>�ȁ�jD�d�D�Rn�l�B�\r��!���\'Id^�ܰp�\'�g͚y��MAY:�������w��m:||@M�a�ȓ<�����R���l`d�6E�b���my�Fe�����F�yn���^@w]rF�ݾ\0 &#�j�W\05A�C�ҕ-��<����rSp�ih��ԣ\0\0} ���ٖ�w\\��~�v?	U��eAz�Ǫ����g�\09!�t$�B�Xn�o�B�\r�1!����m������}]�Q��eA敃�MѮ�JU����|�\0@N�6ɼ4喚�*����*��\n�6\0ƄlS�*f[A������u#%5���r��eAV����Fv�3�0m�WxF�]�\0@��6ɿ4�i�VH�0&d�\"U1ے�~��}^/��%dG�8c�S]�Y������oG6��8$�~^�\0j٦#�(Qk��l�d\0cB�)RU/I���!�]/��%\'obf���%�B�K��5�9��٦#\nAn�6\0ƃlS�*������\"\'����m�U\r:����GX�\'��٦#\nAn�6\0ƃlS$��-+h�ܙ�U����_�\\���.�U�,MT�_�3$�+��C���B��\r�� �I�lK;2mp/�O;���H��YNܙ_]\'h\"�n���O�ϩҫ@�\"�tD!�\r��x�m�$��$��K	������_ܭ��N\0�\r٦#\nAn�6\0ƃlS$�f\0y�������\r��x�m�D���MG�œ�\r�� ��lPd����\'7d\0�A�)��\n�6�On�6\0ƃlS$�f���\0���6�On4�&�(\0@�6E\"�\0T٦#���\r��x�m�D���MGz�������a��/I���e��W��aT�D�0d�\"�m\0��lӑ�e[az��փW��aP�D�0d�\"�m\0��lӑ��-��W]l����N���ֳ���*������M�J�̜y������3��(?�s��.6��(��F�z���?ږ������T�Z6]_t;�R �\\�tbń�����/>�X���W��6\0ƃlS$�\r@�m:�$�:�T�fx%��,����� �kI��_�H)�7�Д&v�w\'�C��[�>��x\\N��S+G5����bƭlˏ�q���㋎�娯��͢�;�2����t������{��7O�Y?����OI�0d�\"�m\0��=����6����ԥ���� ˶��dy���s�ՊR<^n�dҡ�\"u��ε�,Q�\\ĕU=k;���d�:��aK�~��.��Ξ������y��O�<�2��G�~��\r���6\0ƃ��\"�m\0��=����6������,��}�#�Q�w?װ��\'3��2O���r�Δ[�H�;��~��9M�e��`�gݿ�,��C�;8��{�O����x��V$�\r@�ȩ�����2 ������ζ���:ٍذq���l��+u�B\'�.KBom���y��m?�(;�V���r�Ϙ+����0?0W3�0\'�rXL�Al#�\0�M��6\0U0d�WWW������⢏��C��C���gݠN��/i�K�����3n\'����8�z��y��o���aV6O.?��V_?<�o���MϋX?����%Gcs�#v��h��-�4}<�jC�0d�\"�m\0� 99y�رw�/��2e����.�V��v�����𼲻���7��Z�Ķ˘9{���u%ɄC_���־פ���Kr���z44S͚����?�PO���h6�ԣ\0\0}P�mJD�\0��l`<�6E\"�\0\0�G�0d�\"�m\0\0�#�\0�M��6\0���m\0�٦Hd\0@��6\0ƃlS$�\r\0�|d\0�A�)�\0P>�\r�� ��l\0T]A̦~�N��E꫻?Ѿ~I�u:���l�Ǧ\r��x�m�D�\0��V�e^^5���㋏���&���ؤ�L_���x�m���l+\0TUQv��m����;���/=�Z���s}��_�ԩs���?�\Z�.�>1�թᠷƵ5S��2����g���*]�W�����c�M�J׬+�Ļ�����zaqa�����7U�j�t}~���B�ku���kSG��h=��I�̝�$���ʔUs5����Ѧ����I�lUF�mR�\0��lS$�\r\0dM���E���Ĩ����~z�֬��k��_uR�]<K��L�}��ej���^�j������P�e�-mG,=��N8�rtC�^�.%x�bo?�#�d]ޯ5�{~wrQ����iPw༃19�ĳ�<cg=��k9��z[4yac`�:�ܺ��T*�my冚���ͬ[�/�sud\0�A�)�\0�V�N���YX��z���L;~q1#�+�:�7���R���e�e�M<��ެ󢒼�]ܹv�š7K+?bU�ڎs/$}���x�jũ\Z5�|(�����~��?8���3��\\G�~�ZԵvץa���_q�^�\\�e�/jk7���Ʌ�|ztE�0d�\"�m\0 o9���p�c3s�V݆<��m��K������7Om,N���e�i���M�qmo�p�i�Y\'�mj9|g����ee?�pf�������H�=�a�Ne�N��!���}���Э)����i��eٖ�̹n���z{Z��l`<�6E\"�\0@�\n��\r�m���!�%��//�f�a~�ȶN�}�F�Σ��e\'�U!��&�+ɶ_D���,t2��$��Ѷ+��0w�{!�X�����\rG�9~P�)����zY�ը5s�����������5�-nm��_0v���\\=>3UC�0d�\"�m\0 gy�K��4y}OBAqAڅM��T}z.��cl-&���N:��i�zC�Ffi�T�mbY��Zڍt;��V\'��ko�mAii��-�YϺA�n_kJ-?r�cV6O.9�.̉����i��\'G�{����վ�����\'�(�ٶ��͛��U�8�F�0d�\"�m\0 k�I���he�2�����7�}�z+��[c.}�ɬ�42Q�\Z8�[�y���J�Z&��6�cq�]�8Y�?�&�]���s�fgD�`����J��D\n�,z�GC�$�Y����\rHK(H�Z0���Je���w����}�d����j=�#�����l`<�6E\"�\0����e���{N���x�m�D���!۪�l`<�6E\"�\0���mUE�0d�\"�m\0\0�#�\0�M��6\0���m\0�٦Hd\0@��6\0ƃlS$�\r\0�|d\0�A�)�\0P>�\r�� ��l\0(��x�m�D�\0��l`<�6E\"�\0\0�G�0d�\"�m\0\0�#�\0�M��6\0���m\0�٦Hz�6I!\0\0�l�z\0���S$�\r\0�|d\0���;EҒmE5�\0@*d\0���;E\"�\0\0�G�0��S$�\r\0�|d\0���;E\"�\0\0�G�0��S$�\r\0�|d\0���;E\"�\0\0�G�0��S$�\r\0�|d\0���;E�k�\0\0\0�i�tj�^�-\0\0)h��H=\n\0��M��6\0���m\0�٦Hd\0@��6\0ƃlS$�\r\0�|d\0�A�)�\0P>�\r�� ��l\0(��x�m�D�\0��l`<�6E\"�\0\0�G�0d�\"�m\0\0�#�\0�M���mj\0\0���6�G\0�@�)�\0P>�\r�� ��l\0(��x�m�D�\0��l`<�6E\"�\0\0�G�0d�\"�m\0\0�#�\0�M��6\0���m\0�٦Hd\0@��6\0ƃlS$�\r\0�|d\0�A�)�\0P>�\r�� ��l\0(��x�m�D�\0��l`<�6E\"�\0\0�G�0d�\"�m\0\0�#�\0�M��6\0���m\0�٦Hd\0@��6\0ƃlS$�\r\0�|d\0�A�)�\0P>�\r�� �I�ٖ\0�4�&�(\0@�6E\"�\0\0�G�0d�\"�m\0\0�#�\0�M��6\0���m\0�٦Hd\0@��6\0ƃlS$�\r\0�|d\0�A�)�\0P>�\r�� ��l\0(��x�m�D�\0��l`<�6E\"�\0\0�G�0d�\"�m\0\0�#�\0�M�d�m�m��}{Bn��o��̨�6\0@��6\0ƃlS$��-;����]����{���7�*�y����F�L���\0�@d\0�A�)��ٖ�cr��u,M�f�un�[϶倩�cr��:\0(���-!!aΜ9=z�P��^�l���-uo2�RP�mJ$}�ݔ�5�ů����r\0�{J�G��ԩSE	����ڵ��|��M�6ݸq���������s��_�զMɷ�6E�M�����.{����Y3g���M�o�@�\0������f��݇����?��G��26+W�ttt�|KU���dOOϫW�J�I2$��{���n)�m�$�lˍ�k��ʦ�#Þ|�̳��H��\0�\\r�61�#:t���Y3l�����<FeϞ=�oA1��8�������TJNN��������t�jI6D�J��@�)�l�-i���O�/���\0��̳�h�?�x�Z�4�7D�U���H�˲-\"\"b��ݛ7o���߶m���o߾�{��ڵk˖-�F�,H��@�)�^�-�.R<\':���z�Y\0\0�?���zډ��@Sk�/��z�ꊳɷ`Y�����>}Zܸ|�rY�ddd������&��D�-�M�d�my�G�;`Ȍ�|#�\'%�ܒ����7\0@�.۞{�977�\r�V�X�|�r����H��\0Է�۷/555==��ի7n������ܱcǟ��6z�o)�m�$�lK��L����5Q_/p\0�r�<ێW�駟�ٳg�-�}��薊�ɷ�&�222����n�*n���̝;w͚5\"�.\\�w)����۳���(iH��@�)�l�M�v�r��._MS��\0P.�gۉ\n����\r6h\Z�����7ި8���|j����3\'\'G�\'k׮�&~�)<<\\L�E˥����2��#��٦H�ɶ�����;���u���f������)�yy\0�L��v�//���~����7v�ڷo߬Y��N����&�失�|j��ʕ+�܎=*n�:u���/�3__߫W�jn�����$\'��٦H��6u��ꫬ;�t�S�Q��ݛ��,{��=$K_/p\0�r�<�N���[o8p@���իE��+%\"a�����\"&N�(��Q�|��l�������hѢ�����ԕ+W;vl۶m[�l3�혖�&]:II�-�M�d�m���k�mѥ����vz�ǫ���F�x�#1O_/p\0�rD�͟?���[s�{Q����?D����>��3i�I*�o��l���[*>>������S���5�߄�;wFFF��;~���p�œt$�R �IK�׌{�N�1���;�����n���41e׳�ϓ�$\0L��v����{��\\�ҳ���V6}���Nɷ`Y����l۶m���\"�Ŕ������k~+R-...))�СC�y���[\nd�\"�&�2�?��������ï���ePVn��AM��;I_/p\0�r�<�Μ9�W�}��yxx��f)qcժU���#�,���+W����\rww������4qC��o��&��.��\0ɲIj�o)�m�$�l�ω�q\\#3\'�s���kU�^��lUu���\0�̳��ٳ�7oޱc����̙3>�U��m�D�k֬iw��H��g[����ƍ���ϟ�����޲eKVV��RIN$�R �I>�&�S�3��3#=7.��|��d>�\0�2�6��[����/;w�|���v�޽�ww����^�X�l��6�#���m���{���|��H�S�N��榤�xzz������JRM��|K�lS$�d[f��M��snOP_?�ͼ\rA�5��\0(�̳���w˖-�6m�믿&M�$��\n֯_�r�Jq�믿>p�����|��Up������aLL�h6o���Ǐ�8���|K�lS$��-\'����]����{�\'o�Uf˲�\r��\\�\0�$�l>�쳹s�.X�`�6�J�b6I�I2�oA��V&>>~���\"��VG�%��٦H�g�:n�����X���,��R��m��vǪ��:\0(�̳�:�|�=�PF�-�M��϶�RM�k�}��\0�D���H��6I��@�)�l�-??/=�c�ןϞ5s挛�l$�\0\0L��\0H��6I��@�)�l�M�y��ʦ�#ß\ZQ���O���\0P.�g�9�@�-H��H�-�M�d�mɻǶ~��h>�\0�~ƕm\'�d�*��U�����������[��lK�z��J��?�St���/:Z��x5��ĬK�:[�^�s���}��fmf������m$�o)�m���l+��ԃ��_;�v�Y\0\0�?�|�zډ���^\'�{�¼ߗ�=J�߻���ڙ�v�d�5�H�$߂Z�M�uL�������?br+�^;�٦N���GX���Ruf��D�-�M�d�m�)��;`Ȍ��\"�SRo�P���\r\0P0�gۅ�u��G-,��9Y6��ѥ=M,_{�o�{mmz�����^�Y��2��N6&*U���O|��c�.��=�]�Nώ����vm�;����\'�����	}[Z��<�Vm������\\T��|j˶��u��wr����k�^+��4S3������7�<d������(ϯ��ao&��./,?y#�4�j;�1uT��b�\r:���?U}�WD̖Q֍^=��YV���4���o\"	s�]����i�r�[�G%��6��ζ?�ϰ�-��ֳsza�ORl%�͉��:��M-1�N��]�h[NL����k$�o)�m�$�lK��LUC�&��\0P.�g[`�:��4�Ni~��w�����k�i��\0���Q��LZ����w�W�ZY�xw�����?>y��j�B/�]�R�ZO�x�|��?��֪��=gw}ءv���x�^�ٳpx����|ﵨ����%߂Z�-+����|���q�U��\'�ne��J�8}O�հ����[Y?������ϙ]-���pJI��T��:&%���\'���CtƭX���e{����(YT����v����Ή�qD��>��Jό;�6���I�����l������^[\'�[<�1꺶�f]Z������G�ed�_1��Eϯ/��\ZINĦ���:�MV�6E�M���_�S���<}��\0�%�l�^��6�����8j��~AA;�oc����炂.x��f�����4����n������9��E�/](�x�����g��=����υ�sg��}ل&��>{�Ey]���%������S��؍�������녆v�w\\�����u4s��bv~�:z�@�6���\\;/=��ɠ�9YA_t4�� 0�t����i3�79�$��F���z����ٝ	y��{_j�d�gr~n�ھ���;��Ysf���,����-7����l��+VU�|�.KB�K��#����Բ��K�jw^x)��\".�t������4#��6�L�#���U�n��\n_�|��R=z���3f̦M���� �I6ٖ���wZ�kH��^�\0\0�2�l�0�3���}ާo��$�,�?�o}�ŝ縴~����m��?skI��[4��?N�[>i`k+S3�����٠����v�Em����%��3����b+&����(9��d��+9�l���������[�^����d�e�M7�Ė���:�><s;��3N��v�ָ�;�m����i��|g9��$���S�{���6�������<زtz�Ŧ�OS�a�o-#i�H+���}5#I�6x�#1�l;x��贊�{�\'�Mt��#�\Z�M�d�mi�>~���Ы��JU���%~�z�\0����F��|}}��b`�י��-,��;S�7���@�֒cA/�ӹ��Կ�i~p�c�a��.Ytq�\n�̾{�C�;��i��y��_��-�za��f�~>�ZT`5?�����٦�������%(⦐�.&�>�˼�m?���m�8����U~ʙ3��I�WVU̶��ss:ڍX�~�]�Y��bB���=-��;�u33�BC�S��S�ζ��;�U\'�΋�oms�n^�h���G�i��e�(1�cb�6��^n�x3�#od�\"�&���}y�����I�\0�6d��Z�|���B�R�:�Nd���g+���.�Z=��(n\\пn�Gf�r�|P���^im��şN�qi�R5�d���S}�h�:}]����ޤ�s��^\n<�󫑍T��oo��ע|��Q]�<�ȶ˫��n^z����K���j������ٖ��q��͓KO�eg��ӧ^�w�d�+�򳃗8׳nP���AY7�l�P+�\'������n;�foz%W1�*.6�Ғ>�v�,?�������]]ϥ�\Z���k�ae�֭[E��?e�6iҤ���ˣ��K�v�޽|�����PʍlS$�f[A~��i<jwr\r��\0Fd�ܹ��_.�@��^>�l��������Zz�R�OA�~��ӥ�T�6�������.����i�#{؉�V��Ms?|��O�?ܴ�ʴ�M���g�ߴ���Gv�cQ�����%��;�m��I��ϖ?K1?�ʚ���_���mbj�炱����M�{N��?%/���&��}U��a9eK�?�����<�fM�L��79���u�6-�͹�g�(��l;�����lwe#�2�{�D�-uw����cL[hh���W�.?�<�߁lS$�d[^v�m��Ǘ>f���c�zz}\0������Y.�@����}������%����1��[�u#���]eG��\r�ce�Vކ\rʲ�M�6�?�F�)�l�-i��;�\"n:v]X��^�\0\0e�|�E��;�P��_�m\'�����\0٦#ɷ�]�]�D�58{��.�vG��%���}yd�\"�&��ҢBn����Wm\0�ʹi��5p#�t$y�m:�|KUfӦM��u������q�F��6�߃J�h��lS$�d��s`��\rlۨ~����=�������\r\00��ᚓ��va1�\n�[\n-$��MG�o��h�K�;wnU�Mc�ĉ�%2D�Gs7d�\"�\'�2|?�l���w�l�c�������e�y��zzy\0�����oݺU���&�s:�<�6I���*������5���������e�6E�M��y�u�O|oM[�ߧ[�q�K�\0\0�ϴi�4��D���Z���y䑟~�I��5��pO5U�R�>\0E��U�ͧ����t��D���Ddxܾ<�M�d�m�;�j�����I��d�;�\0\0@��s�|kS\r�[��ku��uɒ%w�����\ntP1P�-U�P$�=QU�|e#���|�l�3g��ϓ$�I6ٖ�EW��V_�uVd��oo�eA ��\0T7Qk�/(7i�$1%��NyRiӨQ��?���Z��m�>n�����q��O�Ui!��f�����ɪݫZ�t�鲥�}\0�$I����4��Q}d$!�l+�K���C-�]��O�zzH׆�Z���w=OO/o\0�qILL�;w��[�ބi}�zq�weo���|�ĉǏ�����zO�p�*	��Dd��kj���j��\'���0H������K Ur�H\r٦DzͶ�{(ȸ������ޟ:����2\n�u\0\0���ߊ+Ǝ��� ���H���[������5?�����W��S�]*�)��mҀ�Vf%é����;.D�y��`���W�k�Ⱥ�M�Q��^��|����\n�=���Fu;������_��S����\r��[��ѕ�6��zUJE�)���� ;���y���ύ?����W6\0\0�K��E\'\'�q�����[��O��(F��Qz��M�;��Д_�E�_]>4�S�<s9*2���k3�ŧC�l�R�{�w�+QW�6����w����l���رUc�Yu������p�75����j�&�T�l��Ͷ!C���a��M���mفK�4�4�\'S�Z1����k�r���\0�ڔ9t��\'�xB���ǎ��?\\�r厙��\"�UoS���v���=���ߗ/�7����ȕ���s\'�	���r����o\'�4m�_�`����:~~�J���}�ע����|������6U�=���H��\\���M�-U-U�x�d�=7_���wL�*�d�\r��M�e}�U۩�ɷN�,H=������L=��\0�Nb��X�֭[�7��\'O޺ukRRRe3�\'{J�����-�eSB�����݌C��aG�{s����Y���<�ǺVۏK�͢�r_M��`�����D��Tfm���m;r�_�~�^����J[J� 2��6�7�h9Mn��z���-gŊ��\ZE�)�l�-y��M�o+�-iǓ�F��Rïk\0\0����988L�6���K����Et@i�m\r)���kMj���}������#��D����v2��=Kd�\n���y�4�|���;�?��y�ڶ�7�G�g�B\re[����Ad��m�o>�Q2Qw��4фe����]�\"�I6ٖ�e׆CV^�y������\Zu�2�Ϸ\0���4:��kzq���>��G�;|�ĩ�{�}�۲V��\"\"�~�������E]�\n>�|lc����!�g9�l��.���\r\"���9�y��K|�������n즀h��ZM�@U�T�@���DUi���*���pE�e����%��z$�d�B�&�\n�ox}��Leٲk�}���T�u����|=��\0���?��ŵ���)�a�Z\r�yg�����A[>\Zܼ�ʴ�m�>�.|�y�a����p��ޗ6�h�����\"�z,���.�wioj7���U��_�j�|\0�B�O�ܹs5���6��Kٿ]��I�lS$�d[��x�]��:���gc9�\0P>���$��`(d�D%%%988h�MңG����*5[�EMd~���lS(9e_\0\0\00>d��$��`(��Dmݺ�숙��sJJ�.ob���˚Mܨ�ə� �I>��\0\0\0���?�A�ǀ�02��M�VVn۷o��;X77��\'˿�\n�6��M��\0\0\0�$���Ё�1 �\0������^+;�6}�t��w�)))������]��;͜r��yd�\"�&��\0\0�Q���Ё�1 �\0�A<Q���b�.�΍3�q6\r�M�d�m|\0\0�(��ct yH>\0Ca(OTRR�ܹs�¬�l����Эd�\"�&��\0\0�Q��Ё�1 �\0��=Q[�n�<y��D��;V��;�Xed�\"�\'�J�\0\0\0cS�ٶ���C�_�]}�H��?�a{�X������o�� yH>\0C�%9�M���m���y�����^�5��\0@��1��\\9����=og���ӿ�����շ��i�̜>�8w1�:{/�ǀ@U���8I��@�)�청 ���憐hW[�����y�\\I\0�hb��T�����Ȭת�7n�wbV��ic��\Z���ck�|�M}��#q\r:�^p \"1����l��絡�[4��k���EG�����O�ע���ܾ����\"c�?�jUr?�z����t#|����54�mk�1�{.��׺��!Id��$�R �I>�V���,ČuL[��Qp�;\0\0�\0b��\\�b<^ٶ�R�͟�O�n�R�}oK@p�Y�9],Z��������5�l�z{fN{�����a7�o���BC��]�m�u��_O���-��}�$$\'�y����_#�bo�}�~��3w\\������	���Ŗ[W5>$�c�lӑ�[\nd�\"�5۴��.̹ztӌ1NuUf����߿٤ǒP�~��\0\0 \r�L�~�J�-8����O�ng���\'A�N�~��bLRr������lm����kg��7w��/�t��X8|t,��	\r�\Z;��m�C㓒�5ˊ?,�m��Q))�A��2o������81��E�o���^W5���$�����٦H2ȶ��C�Lڿ�tXF��1�Є�d\0�X�/�,��--�x��Ҷ��y��y��M�v��f�E��B4w�����.G㓢�|��3��j�Q��xq�wtr�l�?�a�;/����w�uU�c@�\n�(ɑm�$�l�\r����m�U\r:���݁�q�6\0��������Zc��߆$��9��\'�,�m�������om�Qk|bK~���Ugs�OOǜ��޲����;D���ek�#W�{�}(,1559���EOۘ�Xz>1����\"�~��\n\\��B�9A������!1���U�$��`(x�$G�)���TaF�����Z_U��D����BK�\0�pb��V��=_��]H�͟o��T�\r��ii�~_8�4~usxrZ��S�=�T�j�����,��	��!��m�[=��v�wg�RR.�?ߨ���b��GK����b���U�ֳ~����7R���V[ӦS�F�^Wu�<$�����٦Hrɶ[r���6��&%_2���O���[��l\0\0$$�x������lM��s��OEJm��&n�F���X�i]���\'}�6���S����+ɶ0���2Hdۉ���\Z��R������\\�N�L86�e���_+�3%r��g�ڙ�|�[�^�~s\"6������1 �\0O���6E�[�ݔ�zq������➔�{I\0 =�̀$��`(x�$G�)�L�\r\0\0#A��H�7��P�DI�lS$�\r\0\0)��c&t ���{��0o�����f���xI��%],����_\r��/�M��6\0\0�$��YЁ�o$�6)&�\nӃ=���U\r��3�M��6\0\0�$���Ё�o$�6�\'�r/}����i��Ԫ�m=��/��OK�>ں�D�4�̙��i^��?����=��bSK���i��Gl^��m��-|���L��e��E�3)%</H:�bBO{�҉�M��U��6E\"�\0\0���?�@��� �t$�l��Ru�ᕐ/�l�+��ܯ%yL��٣��w釦4��;�P���������rr��Z9��E�E3ne[~��ì�_t4.G}���n��9������8�����g�y������r>%٦Hd\0\0R��\\�@�7d����m�]���Kq��A�m?	��8�Vs��D��x�ܨɤCiE��ŝkwY����+�z�v����6u��Ö3�4�]fE�=})1\'z}?��y\ne��9���Gˣ��6E\"�\0\0�٦#��H�m:�W�Y�w�՜���u�e����9؎ڞ�������?�YT�y❦��v�}�T�ޑV��<�i�-+p~�>���d9��R��q�߃��:�m�D�\0 %�TC��� �t$�l+ʽ0��݈\rG�9����R/t2��$��Ѷ�oz��?���@���mE�>+g-��	���E�������9	��b��q��lS&�\r\0\0)��ct �	�MG�϶\"u貞������%Mv�C����{������gW��7���B��϶�0���������������ݣ�y��Z�<��hlnAvĎ�M����&�/�lS$-�VSk���-\0\02$���Ё�o$�6@��G�`���*<��n����v��7��2fΞ��]I2�З�4���5i�����8���\rM�T�&}���O+��!W@�)�\0�����\0:���٦#ɷ�6E\"�\0\0�٦#��H�VXG�o)�ZU$�f����\0\0���B�@�7�֑�[\n�V�l\0@Jb����,����;�=zH��RSSk�m�b8;;K��@�)�\0���:o޼���\"k�Y�>}��cpuu���N<K...�n)�m�D�\0 %lcǎ��{{�oS�L�zC��t\"�-٦Dd\0\0\0�d�\"�m\0\0*ooowww������Y:-���:�6E\"�\0\00T�\'O��y��I=\0� �PM�6\0\0���;�3��Qչ����r�Թ�C��o�R��\\�\Zzk\\[3U��+��y.x��M-���i��G\\��_A������T�Z6]_r;�Z(&&�\\�JO{�҉�/>�$&�����í�Č��{���\'�����Z�^�����am��T���=��9نG�\0`x�o����&�(\0i�l��R9�x&�l:<өA��a�A��U��폈��Y���v�������+G7����R���[Y[t,>7/��\'�,��{<�����4�;p���u��o����ӵĿG۴xsO\\^Q^���m�\r�.\"�8E�D�w�	]�ۢ���)�֍o�R�mxpd\0\0����A�X)7\'�mNu�o�),�� zmoˮ�.�smo�yQI��.�\\���Л����gm��=�>l�0�?�tZQv�ϙ��ܫ���7��t�f��s-����9�ެ�����s\nK��g�8�@�ݿ;��k��K�4kϿ�ֽ6نG�\0`x���\'O����0N\"ۺ؏۟~����[��v�ǵ���?_=�u�ݦ��w�ޚ?m�(+�	���`�g�Ղ�K�\r���;���q�V����ݢ���a�WW���YXq�ֻO_�fs��[o��L���Mg�\r�l\0�����z��JN����6ZS`�K_v�p^r�$�~I����ɼ˒�[Gۮ|����s�5-ʎ�g�����3��w�,:�Rk&�����q����|Qj��GV��5��:B��ebn������(w|� zMo�����m\0\0l���666���R�����m-&���N:��i�zC�Ff�e[q^貾�v#�N%�Չ>��ڛw[�u���V6O-?}#//��k�z-�;����1+�\'��S�D�x�Ѵ��^AY�=��RfaQn�\Z��s\\^������~89r�c��G��MVg�<��mCu �\0\00\"ۆ��� �@\0)�d�Y�&hd�R5p\Z���zAɕ$˲��8?n��\'k���Ķ�ع{��dS��C_>��h�k���%�$Y�b��bI*�&}_[�^T�{�����,��~�\'f��Zro��޽� �k���V*�i�Gߙ�ˊ�$���6\0\0LDD��C\0�Tz�d��B�\"Sd�\"�m\0\0gg�ɓ\'�l\0�vwd�\"�m\0\0\0www�\'upp�z$\0�vwd�\"�m\0\0ooo�D���6E�k��В\0P�)S�DFFJ=\n\0��w݊D�\0 ke�G���J=\0�w݊D�\0 k��\\\\\\�\0���nE\"�\0\0�/΍PU��V$�\r\0\0�rss{O�����[��6\0\0d������F�W��\00$��V$�\r\0\0��$I\0UŻnE\"�\0\0�WWסC�z{{K=\0��w݊�%�\0\0\0\0.I�5��\n\0�줦���6\0@�\r\0\0q/%�(\0\0�B�\0 ���666*��/�\0�G�\0 #���|Q\0�d\0\0����\0�!�\0\0�^@@������sjj��c\0��\0��D�988L�2E��\0\0��l\0@RKI=\n\0��m\0\0HI�������+�\0��\0�����U*ոq��\0@��6\0\0$�}�v�\0��l\0@\Z���...\0���6\0\0�1e�N�\0��l\0@\Z�����8�\0�\'�\r\0\0}�Z�\0�*!�\0\0зq����ظ��K=\0�a �\0\0�7�J)�@\0\0��l\0@4\0@wd\0\0����2t�P�\r\0P%d\0\0z\"jM�R���p=\0@��m\0\0��(��۷K=\n\0��!�\0\0����\0�G\00Hd\0\05n���*������#\0��l\0�ƉZsuu���\0\0��l\0�fq�H\0�\"�\0\0�A���*�j�С�	\0�od\0\05Hd��������\00�\r\0���I�\0�D�\0P#��������?\0���m\0\0Ԉ)S��T*�_�\00xd\0\05�+�\0��\0\0\0\0�F�\0\0\0���m\0\0\0\0 kd\0\0\0\0�\Z�\0�M�U!�`\0F�l\0]����rppP�\ZZb~qcܸqbQ���b�|�6\0�&�m\0\0�)���)S���rvv74٦9n� ��YxY�%�勵hVA�\0��\0P MGi��i:���M�g6�u�5j*N3M��m\0\0\0%!�\0\0\n Jiܸq�s��I������\"�4gc��q��J=.\0�� �\0\0O�或������E&I=�JEFF������\0�\r\0`�4W�&��kw\'�rʔ)���b�R�\0`�a\0\0�蟐���K�v��]䐈\"wwwYs�������i�F�8s��\0�;\0����{�����׏=ZL�\\�Q��$�s+�1)3x���?�\\�Z�P�6\0���a\0\0��u			�$zɦ��Q�������-�8f̘6m�h�(~ܼys��	d\0@G�0\0\0O�ٶ�\'nذ!44Tk#��\"��*NܥG�ⶋ�K����F�׵������H��|a��1u�T1��g�j�P�d\0@G�0\0\0O���2K��4��DJ-[�LRe���\'MA��%*N�3͑4�:�����(!!A�#֢Y���0�6\0���a\0\0�\'I�e�或�$�Ɋ����W�E�E�KsHM���(��[�ld\0@G�0\0\0O�g�ʄ��j��M�8�|�iZ�,��Zt��h�LSh�#Ms N�P�I�d\0@w�0\0\0O�϶U9M˕�\\���t���&�4�v�H+�{|�\r\0P%�0\0\0O�OXX�ƍ��l���g�h�l�-�\0�;\0����5�ʟ9g�QJ�	9��.�F��m+��l\0��\0��ݑmw%\"��g�����\\U�NsM�i\n��϶��b��ʖ@�\0t�\0`���m������r��?ۦY�f�w�4�\r\0p��a\0\0^U�M&�6\0���a\0\0���|D�\0t�\0`��6\0����\0\0<�\r\0�l�0\0\0�l\0(;\0��#�\0\0��\0`��6\0����\0\0<�?�l\0��\0���m\0\0ec�\00xd\0@��a\0\0�\0P6v\0\0�G�\0��\0���m\0\0ec�\00x�\n\r�\0�;\0��#�\0\0��\0`��6\0����\0\0<�\r\0�l�0\0\0�l\0(;\0��#�\0\0��\0`�D� �\r\0�#v\0\0�G�\0��\0���m\0\0ec�\00xd\0@��a\0\0�\0P6v\0\0�\'���\0�m\0\0��\0\0<�\r\0�l�0\0\0O􏍍��ɓ�oߞ��\"u�݃��0�\0�;\0����8;;�\Z;v���[DD�ԁv��IQkb����\r1`��3\0�� �\0\0�)�mܸq��D�M�>]��$	\'V*V=o�<ML:��ՕZ\0��\r\0�L�����D)�^�)%n�����KII���k�����Y��Q�Q�\'\0`��6\0�Q���,_q�cqⶋ����]�JK󻹹i\"M,GUJ�@www��\0��\00R�T�%BK���TF988��L�2Es0�J�\0@U�m\0\0\0\0 kd\0\0\0\0�\Z�\0\0\0\0�F�\0\0\0���m\0\0\0\0 kd\0\0\0\0�\Z�\0\0\0\0�F�\0\0\0���m\0\0\0\0 kd\0\0\0\0�\Z�\0\0\0\0�F�\0\0\0���m\0\0\0\0 kd\0\0\0\0�\Z�\0\0\0\0�F�\0P=�2\"C���mr\0ྑm\0��e�l��C��g�//�b�gCLaM�3��ϻ8���ÿ�(���̣o5Q���{\"�&v�~3:4}�+��{=]��v~>�gS��\'ܲ���ٛ�s�>d��\00td\0�r%�f�{u@�������2Cl��̩�u�u�wɶ⤝�\Z�?��ݨ-7�jdlw#��Fv�L��C�7u���&6O��v:�ʕ�3۾x������W)�ʍ\0`��6\0@�J������腲�Iy!_w�}x��Otj�Զ�]��V��,��8\'����m`Vr���i��3i��������E/:ۋ9k�t}i�OZQ�CUZ�Si�^��h}�/�]Xܭ^�o��˦W\\Ee~�l�Z�k3�@|��+�(��~�N�B�*>���\r�ۖ�v�a�\"s������{�uU*�&����Fm?��-�PR����r���aQ��ic^���v`��Ո-7�\\��C�[���;���Ƽq�W��M/.�*?���RN����޴��>��xr�?bl]>:��aNm��X5{t斿��ٶ��eþS����#�\0��D�\0*�C�uR�:�<�X(�g���[�167dqw�6������8����ٚ����m��k�ne=l�����ޟt�h�r׶�ʲ-?dQ���F��8Ԫ�G>�c]��V�ub����-mG,;y]�w��7�Z�Z�YI�U|,E��n���Q��\ZP�ѳkϥ����Js����Vx}���[{��v�\nKʻ�`3��Ѥ�$�T������O��P��k�M�7�����{Lm[o��\"��m+����u�����K�Y������om�ON��y��J���ݢTs/.�b�~^���_K\0�@�\0*W��mf]\\������o�J�s�e�Oϋ4���**�ψ;��������e΀��t��I�✫�gC��^�u9�d[�χvc��fqʾ�\Zڽ�;������\"O�Ĝ�%�kwYv�(]A�ꞵ��T�m���l�sN��EN���]�\\+�(�}�E�;�M(L=�y��u���R��8�ß�J����sfZ�z��_�O���vcv&���=�ެ��<p�znQQqٶ�9��k��7���͓6Ձs-�m��(��yqh�؊�v������z��~�a)>\0��\0�\\�g�z.?zSXTr^���Ĳ����O��nb�0�\\nn��wl`fnݪېg���aAi��9����}�_���x�O�Ժ��V���j�9�&f�%LKn>�>��$G-��:1�ԻM-���v���}���\'�-�m��ʲ�⣮,��������ʭ(�Є�ݙm�Ꜽ[��+̌:��5GS������������16��{�\Z���t1Ei���ݢ�x�\r{��گ�Sp�ǣ>��Cw^X�q���%cs�+]O��G-�~v��[��+\r�_=̇�\0@F�6\0@�t9I��,���~`m�g��U2� |E7�.j�6�H��eG�����f�҃	�7�wU�r�e[��?������!�.�~���L??�.�Ӳ��kZ&�\\Z�d�e��[G�\"V�0w���~�-vޥ/;��%ۦ4�%�|�}թ�Ѷ�����Ѷ⤭OX���ܳ^����C��W����NV����N�fSg�,\"+��!����[QG�ck���Ȃn��0��^��˻�|u����̜�c#�\0@��6\0@��\'�|�v5i�������0��J%�#C[�d]sne�Ԋ3���7�������㙷��u9Z�� 򻾵[|p:��Öv��p���m�(Ժް�}-�F�<}#//��۱��ݾ�M�c�e�!+|���7�,�й�l�>�n�:�֜��(���Ȍ�}-�<��\\�:��/SZW�l[Q��7���\rx��ݧC�����\'�j3�d��g�s��N�ڼ{��^�8��������ՑNh\\oX�I���S��1+�\'���+ʍ����i���$�m\0`8�6\0@��\'��e\'��D+�i����|���lFn�\r֖:�&z���u�I���&���Y��\"��	��m��y�M�����U=��4�x���B-��G�zE��{���L��2v�ޘ�#oٗ6L���B���q���O7�VY�����R�r��7��\'���uۇ�[���4}���;��<�V�:z����[�)=�Ѣi�g?�Y6KAԚ~%��{��#�xPK˒��o�Ĭ���~^��x���tt��=\Z��|<�I��֝�(�#�\0�p�m\0\0�U~�)/��\\MxF��U�yudAP����F�r�G\00\Zd\0\0z�svZ+�^N$��D�|��Eǹt-�����s�f���W���\0\0�G�\0�_E��i��TY�z��_Bs*~yx%r|>j�R5~bI@���\0>�\r\0\0\0\0d�l\0\0\0\0Y#�\0\0\0\0@��6\0\0\0\0�5�\r\0\0\0\0d�l\0\0\0\0Y#�\0\0\0\0@��6\0\0\0\0�5�\r\0\0\0\0d�l\0\0\0\0Y#�\0\0\0\0@��6\0\0\0\0�5�\r\0\0\0\0d�l\0\0\0\0Y#�\0\0\0\0@��6\0\0\0\0�5�\r\0\0\0\0d�l\0\0\0\0Y#�\0\0\0\0@��6\0\0\0\0�5�\r\0\0\0\0d�l\0\0\0\0Y#�\0\0\0\0@��6\0\0\0\0�5�\r\0\0\0\0d�l\0\0\0\0Y#�\0\0\0\0@��6\0\0\0\0�5�\r\0\0\0\0d�l\0\0\0\0Y#�\0\0\0\0@��6\0\0\0\0�5�\r\0\0\0\0d�l\0\0\0\0Y#�\0\0\0\0@��6\0\0\0\0�5�\r\0\0\0\0d�l\0\0\0\0Y#�\0\0\0\0@��6\0\0\0\0����X\0\0\0\0`���4v�Ek�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0��m\0\0\0k�\0\0�{]ڊ��7\0\0\0\0IEND�B`�',	0);

DROP TABLE IF EXISTS `ACT_GE_PROPERTY`;
CREATE TABLE `ACT_GE_PROPERTY` (
  `NAME_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `VALUE_` varchar(300) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `ACT_GE_PROPERTY` (`NAME_`, `VALUE_`, `REV_`) VALUES
('deployment.lock',	'0',	1),
('historyLevel',	'3',	1),
('next.dbid',	'1',	1),
('schema.history',	'create(fox)',	1),
('schema.version',	'fox',	1);

DROP TABLE IF EXISTS `ACT_HI_ACTINST`;
CREATE TABLE `ACT_HI_ACTINST` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PARENT_ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ACT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `ASSIGNEE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime NOT NULL,
  `END_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `ACT_INST_STATE_` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_ACT_INST_START` (`START_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_COMP` (`EXECUTION_ID_`,`ACT_ID_`,`END_TIME_`,`ID_`),
  KEY `ACT_IDX_HI_ACT_INST_PROCINST` (`PROC_INST_ID_`,`ACT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `ACT_HI_ACTINST` (`ID_`, `PARENT_ACT_INST_ID_`, `PROC_DEF_ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_ID_`, `TASK_ID_`, `CALL_PROC_INST_ID_`, `ACT_NAME_`, `ACT_TYPE_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `ACT_INST_STATE_`) VALUES
('StartEvent_1:b01ab08f-8f8c-11e4-a486-0a0027000000',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	'StartEvent_1',	NULL,	NULL,	'Invoice\nreceived',	'startEvent',	NULL,	'2014-12-29 19:58:34',	'2014-12-29 19:58:34',	1,	0),
('StartEvent_1:b02a40f9-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'StartEvent_1',	NULL,	NULL,	'Invoice\nreceived',	'startEvent',	NULL,	'2014-12-29 19:58:34',	'2014-12-29 19:58:34',	0,	0),
('StartEvent_1:b0369d18-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'StartEvent_1',	NULL,	NULL,	'Invoice\nreceived',	'startEvent',	NULL,	'2014-12-29 19:58:34',	'2014-12-29 19:58:34',	0,	0),
('approveInvoice:b0331aa3-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'approveInvoice',	'b0331aa4-8f8c-11e4-a486-0a0027000000',	NULL,	'Approve Invoice',	'userTask',	'john',	'2014-12-15 19:58:34',	NULL,	NULL,	0),
('approveInvoice:b0425cf1-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'approveInvoice',	'b0425cf2-8f8c-11e4-a486-0a0027000000',	NULL,	'Approve Invoice',	'userTask',	'mary',	'2014-12-24 19:58:34',	'2014-12-24 19:58:34',	273,	0),
('assignApprover:b01ad7a3-8f8c-11e4-a486-0a0027000000',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	'assignApprover',	'b01ad7a4-8f8c-11e4-a486-0a0027000000',	NULL,	'Assign Approver',	'userTask',	'demo',	'2014-12-29 19:58:34',	NULL,	NULL,	0),
('assignApprover:b02a40fd-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'assignApprover',	'b02a40fe-8f8c-11e4-a486-0a0027000000',	NULL,	'Assign Approver',	'userTask',	'demo',	'2014-12-29 19:58:34',	'2014-12-15 19:58:34',	-1209599806,	0),
('assignApprover:b0369d1b-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'assignApprover',	'b0369d1c-8f8c-11e4-a486-0a0027000000',	NULL,	'Assign Approver',	'userTask',	'demo',	'2014-12-29 19:58:34',	'2014-12-24 19:58:34',	-431999727,	0),
('invoice_approved:b0545e58-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'invoice_approved',	NULL,	NULL,	'Invoice\napproved?',	'exclusiveGateway',	NULL,	'2014-12-24 19:58:34',	'2014-12-24 19:58:34',	0,	0),
('reviewInvoice:b0548569-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'reviewInvoice',	'b054856a-8f8c-11e4-a486-0a0027000000',	NULL,	'Review Invoice',	'userTask',	'demo',	'2014-12-24 19:58:34',	NULL,	NULL,	0);

DROP TABLE IF EXISTS `ACT_HI_ATTACHMENT`;
CREATE TABLE `ACT_HI_ATTACHMENT` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `URL_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `CONTENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `ACT_HI_CASEACTINST`;
CREATE TABLE `ACT_HI_CASEACTINST` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PARENT_ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CASE_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `CASE_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `CASE_ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CALL_CASE_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CASE_ACT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CASE_ACT_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` datetime NOT NULL,
  `END_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `STATE_` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_CAS_A_I_CREATE` (`CREATE_TIME_`),
  KEY `ACT_IDX_HI_CAS_A_I_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_CAS_A_I_COMP` (`CASE_ACT_ID_`,`END_TIME_`,`ID_`),
  KEY `ACT_IDX_HI_CAS_A_I_CASEINST` (`CASE_INST_ID_`,`CASE_ACT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `ACT_HI_CASEINST`;
CREATE TABLE `ACT_HI_CASEINST` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `CASE_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CASE_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `CREATE_TIME_` datetime NOT NULL,
  `CLOSE_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `STATE_` int(11) DEFAULT NULL,
  `CREATE_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_CASE_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `CASE_INST_ID_` (`CASE_INST_ID_`),
  KEY `ACT_IDX_HI_CAS_I_CLOSE` (`CLOSE_TIME_`),
  KEY `ACT_IDX_HI_CAS_I_BUSKEY` (`BUSINESS_KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `ACT_HI_COMMENT`;
CREATE TABLE `ACT_HI_COMMENT` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TIME_` datetime NOT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `MESSAGE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `FULL_MSG_` longblob,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `ACT_HI_COMMENT` (`ID_`, `TYPE_`, `TIME_`, `USER_ID_`, `TASK_ID_`, `PROC_INST_ID_`, `ACTION_`, `MESSAGE_`, `FULL_MSG_`) VALUES
('b04dcea3-8f8c-11e4-a486-0a0027000000',	'comment',	'2014-12-24 19:58:34',	'mary',	NULL,	'b0369d15-8f8c-11e4-a486-0a0027000000',	'AddComment',	'I cannot approve this invoice: the amount is missing. Could you please provide the amount?',	'I cannot approve this invoice: the amount is missing.\n\n Could you please provide the amount?');

DROP TABLE IF EXISTS `ACT_HI_DETAIL`;
CREATE TABLE `ACT_HI_DETAIL` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CASE_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CASE_EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `VAR_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TIME_` datetime NOT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_DETAIL_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_ACT_INST` (`ACT_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_CASE_INST` (`CASE_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_CASE_EXEC` (`CASE_EXECUTION_ID_`),
  KEY `ACT_IDX_HI_DETAIL_TIME` (`TIME_`),
  KEY `ACT_IDX_HI_DETAIL_NAME` (`NAME_`),
  KEY `ACT_IDX_HI_DETAIL_TASK_ID` (`TASK_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `ACT_HI_DETAIL` (`ID_`, `TYPE_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `CASE_INST_ID_`, `CASE_EXECUTION_ID_`, `TASK_ID_`, `ACT_INST_ID_`, `VAR_INST_ID_`, `NAME_`, `VAR_TYPE_`, `REV_`, `TIME_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES
('b01ad7a0-8f8c-11e4-a486-0a0027000000',	'VariableUpdate',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'StartEvent_1:b01ab08f-8f8c-11e4-a486-0a0027000000',	'b01a897c-8f8c-11e4-a486-0a0027000000',	'amount',	'string',	0,	'2014-12-29 19:58:34',	NULL,	NULL,	NULL,	'30€',	NULL),
('b01ad7a1-8f8c-11e4-a486-0a0027000000',	'VariableUpdate',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'StartEvent_1:b01ab08f-8f8c-11e4-a486-0a0027000000',	'b01a897d-8f8c-11e4-a486-0a0027000000',	'invoiceNumber',	'string',	0,	'2014-12-29 19:58:34',	NULL,	NULL,	NULL,	'GPFE-23232323',	NULL),
('b01ad7a2-8f8c-11e4-a486-0a0027000000',	'VariableUpdate',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'StartEvent_1:b01ab08f-8f8c-11e4-a486-0a0027000000',	'b01a897e-8f8c-11e4-a486-0a0027000000',	'creditor',	'string',	0,	'2014-12-29 19:58:34',	NULL,	NULL,	NULL,	'Great Pizza for Everyone Inc.',	NULL),
('b02a40fa-8f8c-11e4-a486-0a0027000000',	'VariableUpdate',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'StartEvent_1:b02a40f9-8f8c-11e4-a486-0a0027000000',	'b02a40f6-8f8c-11e4-a486-0a0027000000',	'amount',	'string',	0,	'2014-12-29 19:58:34',	NULL,	NULL,	NULL,	'312.99$',	NULL),
('b02a40fb-8f8c-11e4-a486-0a0027000000',	'VariableUpdate',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'StartEvent_1:b02a40f9-8f8c-11e4-a486-0a0027000000',	'b02a40f7-8f8c-11e4-a486-0a0027000000',	'invoiceNumber',	'string',	0,	'2014-12-29 19:58:34',	NULL,	NULL,	NULL,	'BOS-43934',	NULL),
('b02a40fc-8f8c-11e4-a486-0a0027000000',	'VariableUpdate',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'StartEvent_1:b02a40f9-8f8c-11e4-a486-0a0027000000',	'b02a40f8-8f8c-11e4-a486-0a0027000000',	'creditor',	'string',	0,	'2014-12-29 19:58:34',	NULL,	NULL,	NULL,	'Bobby\'s Office Supplies',	NULL),
('b030f7c0-8f8c-11e4-a486-0a0027000000',	'VariableUpdate',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'assignApprover:b02a40fd-8f8c-11e4-a486-0a0027000000',	'b030f7bf-8f8c-11e4-a486-0a0027000000',	'approver',	'string',	0,	'2014-12-15 19:58:34',	NULL,	NULL,	NULL,	'john',	NULL),
('b0369d19-8f8c-11e4-a486-0a0027000000',	'VariableUpdate',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'StartEvent_1:b0369d18-8f8c-11e4-a486-0a0027000000',	'b0369d16-8f8c-11e4-a486-0a0027000000',	'invoiceNumber',	'string',	0,	'2014-12-29 19:58:34',	NULL,	NULL,	NULL,	'PSACE-5342',	NULL),
('b0369d1a-8f8c-11e4-a486-0a0027000000',	'VariableUpdate',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'StartEvent_1:b0369d18-8f8c-11e4-a486-0a0027000000',	'b0369d17-8f8c-11e4-a486-0a0027000000',	'creditor',	'string',	0,	'2014-12-29 19:58:34',	NULL,	NULL,	NULL,	'Papa Steve\'s all you can eat',	NULL),
('b03d2cce-8f8c-11e4-a486-0a0027000000',	'VariableUpdate',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'assignApprover:b0369d1b-8f8c-11e4-a486-0a0027000000',	'b03d2ccd-8f8c-11e4-a486-0a0027000000',	'approver',	'string',	0,	'2014-12-24 19:58:34',	NULL,	NULL,	NULL,	'mary',	NULL),
('b05066b5-8f8c-11e4-a486-0a0027000000',	'VariableUpdate',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'approveInvoice:b0425cf1-8f8c-11e4-a486-0a0027000000',	'b05066b4-8f8c-11e4-a486-0a0027000000',	'approved',	'string',	0,	'2014-12-24 19:58:34',	NULL,	NULL,	NULL,	'false',	NULL);

DROP TABLE IF EXISTS `ACT_HI_INCIDENT`;
CREATE TABLE `ACT_HI_INCIDENT` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `END_TIME_` timestamp NULL DEFAULT NULL,
  `INCIDENT_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `INCIDENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `ACTIVITY_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CAUSE_INCIDENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ROOT_CAUSE_INCIDENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `INCIDENT_STATE_` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `ACT_HI_OP_LOG`;
CREATE TABLE `ACT_HI_OP_LOG` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CASE_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CASE_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CASE_EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TIMESTAMP_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `OPERATION_TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `OPERATION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ENTITY_TYPE_` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  `PROPERTY_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ORG_VALUE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `NEW_VALUE_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `ACT_HI_OP_LOG` (`ID_`, `PROC_DEF_ID_`, `PROC_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `CASE_DEF_ID_`, `CASE_INST_ID_`, `CASE_EXECUTION_ID_`, `TASK_ID_`, `USER_ID_`, `TIMESTAMP_`, `OPERATION_TYPE_`, `OPERATION_ID_`, `ENTITY_TYPE_`, `PROPERTY_`, `ORG_VALUE_`, `NEW_VALUE_`) VALUES
('b0327e62-8f8c-11e4-a486-0a0027000000',	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	NULL,	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'b02a40fe-8f8c-11e4-a486-0a0027000000',	'demo',	'2014-12-15 19:58:34',	'Complete',	'b0325751-8f8c-11e4-a486-0a0027000000',	'Task',	'delete',	'false',	'true'),
('b0408830-8f8c-11e4-a486-0a0027000000',	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	NULL,	'b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'b0369d1c-8f8c-11e4-a486-0a0027000000',	'demo',	'2014-12-24 19:58:34',	'Complete',	'b040882f-8f8c-11e4-a486-0a0027000000',	'Task',	'delete',	'false',	'true'),
('b052d7b7-8f8c-11e4-a486-0a0027000000',	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	NULL,	'b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'b0425cf2-8f8c-11e4-a486-0a0027000000',	'mary',	'2014-12-24 19:58:34',	'Complete',	'b052d7b6-8f8c-11e4-a486-0a0027000000',	'Task',	'delete',	'false',	'true');

DROP TABLE IF EXISTS `ACT_HI_PROCINST`;
CREATE TABLE `ACT_HI_PROCINST` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `START_TIME_` datetime NOT NULL,
  `END_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `START_USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `END_ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CASE_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PRO_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_PRO_I_BUSKEY` (`BUSINESS_KEY_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `ACT_HI_PROCINST` (`ID_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PROC_DEF_ID_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `START_USER_ID_`, `START_ACT_ID_`, `END_ACT_ID_`, `SUPER_PROCESS_INSTANCE_ID_`, `CASE_INST_ID_`, `DELETE_REASON_`) VALUES
('b01a3b5b-8f8c-11e4-a486-0a0027000000',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	NULL,	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	'2014-12-29 19:58:34',	NULL,	NULL,	NULL,	'StartEvent_1',	NULL,	NULL,	NULL,	NULL),
('b02a19e5-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	NULL,	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	'2014-12-29 19:58:34',	NULL,	NULL,	NULL,	'StartEvent_1',	NULL,	NULL,	NULL,	NULL),
('b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	NULL,	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	'2014-12-29 19:58:34',	NULL,	NULL,	NULL,	'StartEvent_1',	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `ACT_HI_TASKINST`;
CREATE TABLE `ACT_HI_TASKINST` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CASE_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CASE_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CASE_EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `START_TIME_` datetime NOT NULL,
  `END_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint(20) DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `DUE_DATE_` datetime DEFAULT NULL,
  `FOLLOW_UP_DATE_` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `ACT_HI_TASKINST` (`ID_`, `PROC_DEF_ID_`, `TASK_DEF_KEY_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `CASE_DEF_ID_`, `CASE_INST_ID_`, `CASE_EXECUTION_ID_`, `ACT_INST_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `OWNER_`, `ASSIGNEE_`, `START_TIME_`, `END_TIME_`, `DURATION_`, `DELETE_REASON_`, `PRIORITY_`, `DUE_DATE_`, `FOLLOW_UP_DATE_`) VALUES
('b01ad7a4-8f8c-11e4-a486-0a0027000000',	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	'assignApprover',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'assignApprover:b01ad7a3-8f8c-11e4-a486-0a0027000000',	'Assign Approver',	NULL,	'Select the colleague who should approve this invoice.',	NULL,	'demo',	'2014-12-29 19:58:34',	NULL,	NULL,	NULL,	50,	'2015-01-01 19:58:34',	NULL),
('b02a40fe-8f8c-11e4-a486-0a0027000000',	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	'assignApprover',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'assignApprover:b02a40fd-8f8c-11e4-a486-0a0027000000',	'Assign Approver',	NULL,	'Select the colleague who should approve this invoice.',	NULL,	'demo',	'2014-12-29 19:58:34',	'2014-12-15 19:58:34',	-1209599806,	'completed',	50,	'2015-01-01 19:58:34',	NULL),
('b0331aa4-8f8c-11e4-a486-0a0027000000',	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	'approveInvoice',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'approveInvoice:b0331aa3-8f8c-11e4-a486-0a0027000000',	'Approve Invoice',	NULL,	'Approve the invoice (or not).',	NULL,	'john',	'2014-12-15 19:58:34',	NULL,	NULL,	NULL,	50,	'2014-12-22 19:58:34',	NULL),
('b0369d1c-8f8c-11e4-a486-0a0027000000',	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	'assignApprover',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'assignApprover:b0369d1b-8f8c-11e4-a486-0a0027000000',	'Assign Approver',	NULL,	'Select the colleague who should approve this invoice.',	NULL,	'demo',	'2014-12-29 19:58:34',	'2014-12-24 19:58:34',	-431999727,	'completed',	50,	'2015-01-01 19:58:34',	NULL),
('b0425cf2-8f8c-11e4-a486-0a0027000000',	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	'approveInvoice',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'approveInvoice:b0425cf1-8f8c-11e4-a486-0a0027000000',	'Approve Invoice',	NULL,	'Approve the invoice (or not).',	NULL,	'mary',	'2014-12-24 19:58:34',	'2014-12-24 19:58:34',	273,	'completed',	50,	'2014-12-31 19:58:34',	NULL),
('b054856a-8f8c-11e4-a486-0a0027000000',	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	'reviewInvoice',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'reviewInvoice:b0548569-8f8c-11e4-a486-0a0027000000',	'Review Invoice',	NULL,	'Review the invoice.\n\n\nIf data is missing, provide it.',	NULL,	'demo',	'2014-12-24 19:58:34',	NULL,	NULL,	NULL,	50,	'2014-12-26 19:58:34',	NULL);

DROP TABLE IF EXISTS `ACT_HI_VARINST`;
CREATE TABLE `ACT_HI_VARINST` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CASE_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CASE_EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VAR_TYPE_` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `REV_` int(11) DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_PROCVAR_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_CASEVAR_CASE_INST` (`CASE_INST_ID_`),
  KEY `ACT_IDX_HI_PROCVAR_NAME_TYPE` (`NAME_`,`VAR_TYPE_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `ACT_HI_VARINST` (`ID_`, `PROC_INST_ID_`, `EXECUTION_ID_`, `ACT_INST_ID_`, `CASE_INST_ID_`, `CASE_EXECUTION_ID_`, `TASK_ID_`, `NAME_`, `VAR_TYPE_`, `REV_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`) VALUES
('b01a897c-8f8c-11e4-a486-0a0027000000',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'amount',	'string',	0,	NULL,	NULL,	NULL,	'30€',	NULL),
('b01a897d-8f8c-11e4-a486-0a0027000000',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'invoiceNumber',	'string',	0,	NULL,	NULL,	NULL,	'GPFE-23232323',	NULL),
('b01a897e-8f8c-11e4-a486-0a0027000000',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'creditor',	'string',	0,	NULL,	NULL,	NULL,	'Great Pizza for Everyone Inc.',	NULL),
('b02a40f6-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'amount',	'string',	0,	NULL,	NULL,	NULL,	'312.99$',	NULL),
('b02a40f7-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'invoiceNumber',	'string',	0,	NULL,	NULL,	NULL,	'BOS-43934',	NULL),
('b02a40f8-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'creditor',	'string',	0,	NULL,	NULL,	NULL,	'Bobby\'s Office Supplies',	NULL),
('b030f7bf-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'approver',	'string',	0,	NULL,	NULL,	NULL,	'john',	NULL),
('b0369d16-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'invoiceNumber',	'string',	0,	NULL,	NULL,	NULL,	'PSACE-5342',	NULL),
('b0369d17-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'creditor',	'string',	0,	NULL,	NULL,	NULL,	'Papa Steve\'s all you can eat',	NULL),
('b03d2ccd-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'approver',	'string',	0,	NULL,	NULL,	NULL,	'mary',	NULL),
('b05066b4-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'approved',	'string',	0,	NULL,	NULL,	NULL,	'false',	NULL);

DROP TABLE IF EXISTS `ACT_ID_GROUP`;
CREATE TABLE `ACT_ID_GROUP` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `ACT_ID_GROUP` (`ID_`, `REV_`, `NAME_`, `TYPE_`) VALUES
('accounting',	1,	'Accounting',	'WORKFLOW'),
('camunda-admin',	1,	'camunda BPM Administrators',	'SYSTEM'),
('management',	1,	'Management',	'WORKFLOW'),
('sales',	1,	'Sales',	'WORKFLOW');

DROP TABLE IF EXISTS `ACT_ID_INFO`;
CREATE TABLE `ACT_ID_INFO` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `USER_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `VALUE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PASSWORD_` longblob,
  `PARENT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `ACT_ID_MEMBERSHIP`;
CREATE TABLE `ACT_ID_MEMBERSHIP` (
  `USER_ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `GROUP_ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`USER_ID_`,`GROUP_ID_`),
  KEY `ACT_FK_MEMB_GROUP` (`GROUP_ID_`),
  CONSTRAINT `ACT_FK_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `ACT_ID_USER` (`ID_`),
  CONSTRAINT `ACT_FK_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `ACT_ID_GROUP` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `ACT_ID_MEMBERSHIP` (`USER_ID_`, `GROUP_ID_`) VALUES
('demo',	'accounting'),
('mary',	'accounting'),
('demo',	'camunda-admin'),
('demo',	'management'),
('peter',	'management'),
('demo',	'sales'),
('john',	'sales');

DROP TABLE IF EXISTS `ACT_ID_USER`;
CREATE TABLE `ACT_ID_USER` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `FIRST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `LAST_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EMAIL_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PWD_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PICTURE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `ACT_ID_USER` (`ID_`, `REV_`, `FIRST_`, `LAST_`, `EMAIL_`, `PWD_`, `PICTURE_ID_`) VALUES
('demo',	1,	'Demo',	'Demo',	'demo@camunda.org',	'{SHA}ieSV55Qc+eQOaYDRSha/AjzNTJE=',	NULL),
('john',	1,	'John',	'Doe',	'john@camunda.org',	'{SHA}pR3afH/1C2Hq6gRENx9KapMB5QE=',	NULL),
('mary',	1,	'Mary',	'Anne',	'mary@camunda.org',	'{SHA}VmUzG5uBmsNYFl+MOJcNyMfdtH0=',	NULL),
('peter',	1,	'Peter',	'Meter',	'peter@camunda.org',	'{SHA}S4Nz0Bbyd1JxmDhbpy/aD+tdoBU=',	NULL);

DROP TABLE IF EXISTS `ACT_RE_CASE_DEF`;
CREATE TABLE `ACT_RE_CASE_DEF` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_CASE_DEF` (`KEY_`,`VERSION_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `ACT_RE_DEPLOYMENT`;
CREATE TABLE `ACT_RE_DEPLOYMENT` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOY_TIME_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `ACT_RE_DEPLOYMENT` (`ID_`, `NAME_`, `DEPLOY_TIME_`) VALUES
('afdf7c1e-8f8c-11e4-a486-0a0027000000',	'camunda-invoice',	'2014-12-29 19:58:33');

DROP TABLE IF EXISTS `ACT_RE_PROCDEF`;
CREATE TABLE `ACT_RE_PROCDEF` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
  `VERSION_` int(11) NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `HAS_START_FORM_KEY_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_PROCDEF` (`KEY_`,`VERSION_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `ACT_RE_PROCDEF` (`ID_`, `REV_`, `CATEGORY_`, `NAME_`, `KEY_`, `VERSION_`, `DEPLOYMENT_ID_`, `RESOURCE_NAME_`, `DGRM_RESOURCE_NAME_`, `HAS_START_FORM_KEY_`, `SUSPENSION_STATE_`) VALUES
('invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	1,	'http://www.omg.org/spec/BPMN/20100524/MODEL',	'Invoice Receipt',	'invoice',	1,	'afdf7c1e-8f8c-11e4-a486-0a0027000000',	'invoice.bpmn',	'invoice.png',	1,	1);

DROP TABLE IF EXISTS `ACT_RU_AUTHORIZATION`;
CREATE TABLE `ACT_RU_AUTHORIZATION` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NOT NULL,
  `TYPE_` int(11) NOT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `RESOURCE_TYPE_` int(11) NOT NULL,
  `RESOURCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PERMS_` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_AUTH_USER` (`USER_ID_`,`TYPE_`,`RESOURCE_TYPE_`,`RESOURCE_ID_`),
  UNIQUE KEY `ACT_UNIQ_AUTH_GROUP` (`GROUP_ID_`,`TYPE_`,`RESOURCE_TYPE_`,`RESOURCE_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `ACT_RU_AUTHORIZATION` (`ID_`, `REV_`, `TYPE_`, `GROUP_ID_`, `USER_ID_`, `RESOURCE_TYPE_`, `RESOURCE_ID_`, `PERMS_`) VALUES
('aff5ea53-8f8c-11e4-a486-0a0027000000',	1,	1,	NULL,	'demo',	1,	'demo',	2147483647),
('aff722d4-8f8c-11e4-a486-0a0027000000',	1,	1,	NULL,	'john',	1,	'john',	2147483647),
('aff83445-8f8c-11e4-a486-0a0027000000',	1,	1,	NULL,	'mary',	1,	'mary',	2147483647),
('aff993d6-8f8c-11e4-a486-0a0027000000',	1,	1,	NULL,	'peter',	1,	'peter',	2147483647),
('affaa547-8f8c-11e4-a486-0a0027000000',	1,	1,	'sales',	NULL,	2,	'sales',	2),
('affb8fa8-8f8c-11e4-a486-0a0027000000',	1,	1,	'accounting',	NULL,	2,	'accounting',	2),
('affca119-8f8c-11e4-a486-0a0027000000',	1,	1,	'management',	NULL,	2,	'management',	2),
('affe27ba-8f8c-11e4-a486-0a0027000000',	1,	1,	'camunda-admin',	NULL,	2,	'camunda-admin',	2),
('afffd56b-8f8c-11e4-a486-0a0027000000',	1,	1,	'camunda-admin',	NULL,	0,	'*',	2147483647),
('b000e6dc-8f8c-11e4-a486-0a0027000000',	1,	1,	'camunda-admin',	NULL,	1,	'*',	2147483647),
('b0021f5d-8f8c-11e4-a486-0a0027000000',	1,	1,	'camunda-admin',	NULL,	2,	'*',	2147483647),
('b00309be-8f8c-11e4-a486-0a0027000000',	1,	1,	'camunda-admin',	NULL,	3,	'*',	2147483647),
('b0041b2f-8f8c-11e4-a486-0a0027000000',	1,	1,	'camunda-admin',	NULL,	4,	'*',	2147483647),
('b00553b0-8f8c-11e4-a486-0a0027000000',	1,	1,	'camunda-admin',	NULL,	5,	'*',	2147483647),
('b00ad1f1-8f8c-11e4-a486-0a0027000000',	1,	1,	'sales',	NULL,	0,	'tasklist',	32),
('b00b4722-8f8c-11e4-a486-0a0027000000',	1,	1,	'accounting',	NULL,	0,	'tasklist',	32),
('b00c3183-8f8c-11e4-a486-0a0027000000',	1,	1,	'management',	NULL,	0,	'tasklist',	32),
('b00cf4d4-8f8c-11e4-a486-0a0027000000',	1,	1,	'sales',	NULL,	1,	'demo',	2),
('b00db825-8f8c-11e4-a486-0a0027000000',	1,	1,	'sales',	NULL,	1,	'john',	2),
('b00e5466-8f8c-11e4-a486-0a0027000000',	1,	1,	'management',	NULL,	1,	'demo',	2),
('b00ec997-8f8c-11e4-a486-0a0027000000',	1,	1,	'management',	NULL,	1,	'peter',	2),
('b00f65d8-8f8c-11e4-a486-0a0027000000',	1,	1,	'accounting',	NULL,	1,	'demo',	2),
('b00fdb09-8f8c-11e4-a486-0a0027000000',	1,	1,	'accounting',	NULL,	1,	'mary',	2),
('b0113a9b-8f8c-11e4-a486-0a0027000000',	1,	1,	NULL,	'demo',	5,	'b0113a9a-8f8c-11e4-a486-0a0027000000',	2147483647),
('b012731d-8f8c-11e4-a486-0a0027000000',	1,	1,	NULL,	'demo',	5,	'b012731c-8f8c-11e4-a486-0a0027000000',	2147483647),
('b0130f5e-8f8c-11e4-a486-0a0027000000',	1,	0,	NULL,	'*',	5,	'b0113a9a-8f8c-11e4-a486-0a0027000000',	2),
('b013ab9f-8f8c-11e4-a486-0a0027000000',	1,	0,	NULL,	'*',	5,	'b012731c-8f8c-11e4-a486-0a0027000000',	2),
('b0149601-8f8c-11e4-a486-0a0027000000',	1,	1,	NULL,	'demo',	5,	'b0149600-8f8c-11e4-a486-0a0027000000',	2147483647),
('b0155952-8f8c-11e4-a486-0a0027000000',	1,	1,	'accounting',	NULL,	5,	'b0149600-8f8c-11e4-a486-0a0027000000',	2),
('b015ce84-8f8c-11e4-a486-0a0027000000',	1,	1,	NULL,	'demo',	5,	'b015ce83-8f8c-11e4-a486-0a0027000000',	2147483647),
('b016dff6-8f8c-11e4-a486-0a0027000000',	1,	1,	NULL,	'demo',	5,	'b016dff5-8f8c-11e4-a486-0a0027000000',	2147483647),
('b0177c38-8f8c-11e4-a486-0a0027000000',	1,	1,	NULL,	'demo',	5,	'b0177c37-8f8c-11e4-a486-0a0027000000',	2147483647),
('b018669a-8f8c-11e4-a486-0a0027000000',	1,	1,	NULL,	'demo',	5,	'b0186699-8f8c-11e4-a486-0a0027000000',	2147483647);

DROP TABLE IF EXISTS `ACT_RU_CASE_EXECUTION`;
CREATE TABLE `ACT_RU_CASE_EXECUTION` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `CASE_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_CASE_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CASE_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PREV_STATE_` int(11) DEFAULT NULL,
  `CURRENT_STATE_` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_CASE_EXEC_BUSKEY` (`BUSINESS_KEY_`),
  KEY `ACT_FK_CASE_EXE_CASE_INST` (`CASE_INST_ID_`),
  KEY `ACT_FK_CASE_EXE_PARENT` (`PARENT_ID_`),
  KEY `ACT_FK_CASE_EXE_CASE_DEF` (`CASE_DEF_ID_`),
  CONSTRAINT `ACT_FK_CASE_EXE_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `ACT_RE_CASE_DEF` (`ID_`),
  CONSTRAINT `ACT_FK_CASE_EXE_CASE_INST` FOREIGN KEY (`CASE_INST_ID_`) REFERENCES `ACT_RU_CASE_EXECUTION` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_CASE_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `ACT_RU_CASE_EXECUTION` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `ACT_RU_CASE_SENTRY_PART`;
CREATE TABLE `ACT_RU_CASE_SENTRY_PART` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `CASE_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CASE_EXEC_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SENTRY_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SOURCE_CASE_EXEC_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `STANDARD_EVENT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SATISFIED_` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_CASE_SENTRY_CASE_INST` (`CASE_INST_ID_`),
  KEY `ACT_FK_CASE_SENTRY_CASE_EXEC` (`CASE_EXEC_ID_`),
  CONSTRAINT `ACT_FK_CASE_SENTRY_CASE_EXEC` FOREIGN KEY (`CASE_EXEC_ID_`) REFERENCES `ACT_RU_CASE_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_CASE_SENTRY_CASE_INST` FOREIGN KEY (`CASE_INST_ID_`) REFERENCES `ACT_RU_CASE_EXECUTION` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `ACT_RU_EVENT_SUBSCR`;
CREATE TABLE `ACT_RU_EVENT_SUBSCR` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `EVENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EVENT_NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTIVITY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `CREATED_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EVENT_SUBSCR_CONFIG_` (`CONFIGURATION_`),
  KEY `ACT_FK_EVENT_EXEC` (`EXECUTION_ID_`),
  CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `ACT_RU_EXECUTION`;
CREATE TABLE `ACT_RU_EXECUTION` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SUPER_CASE_EXEC_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CASE_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `IS_ACTIVE_` tinyint(4) DEFAULT NULL,
  `IS_CONCURRENT_` tinyint(4) DEFAULT NULL,
  `IS_SCOPE_` tinyint(4) DEFAULT NULL,
  `IS_EVENT_SCOPE_` tinyint(4) DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `CACHED_ENT_STATE_` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EXEC_BUSKEY` (`BUSINESS_KEY_`),
  KEY `ACT_FK_EXE_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_EXE_PARENT` (`PARENT_ID_`),
  KEY `ACT_FK_EXE_SUPER` (`SUPER_EXEC_`),
  KEY `ACT_FK_EXE_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `ACT_RU_EXECUTION` (`ID_`, `REV_`, `PROC_INST_ID_`, `BUSINESS_KEY_`, `PARENT_ID_`, `PROC_DEF_ID_`, `SUPER_EXEC_`, `SUPER_CASE_EXEC_`, `CASE_INST_ID_`, `ACT_ID_`, `ACT_INST_ID_`, `IS_ACTIVE_`, `IS_CONCURRENT_`, `IS_SCOPE_`, `IS_EVENT_SCOPE_`, `SUSPENSION_STATE_`, `CACHED_ENT_STATE_`) VALUES
('b01a3b5b-8f8c-11e4-a486-0a0027000000',	1,	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'assignApprover',	'assignApprover:b01ad7a3-8f8c-11e4-a486-0a0027000000',	1,	0,	1,	0,	1,	18),
('b02a19e5-8f8c-11e4-a486-0a0027000000',	2,	'b02a19e5-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'approveInvoice',	'approveInvoice:b0331aa3-8f8c-11e4-a486-0a0027000000',	1,	0,	1,	0,	1,	18),
('b0369d15-8f8c-11e4-a486-0a0027000000',	3,	'b0369d15-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'reviewInvoice',	'reviewInvoice:b0548569-8f8c-11e4-a486-0a0027000000',	1,	0,	1,	0,	1,	18);

DROP TABLE IF EXISTS `ACT_RU_FILTER`;
CREATE TABLE `ACT_RU_FILTER` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NOT NULL,
  `RESOURCE_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `QUERY_` longtext COLLATE utf8_bin NOT NULL,
  `PROPERTIES_` longtext COLLATE utf8_bin,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `ACT_RU_FILTER` (`ID_`, `REV_`, `RESOURCE_TYPE_`, `NAME_`, `OWNER_`, `QUERY_`, `PROPERTIES_`) VALUES
('b0113a9a-8f8c-11e4-a486-0a0027000000',	1,	'Task',	'My Tasks',	'demo',	'{\"taskAssigneeExpression\":\"${currentUser()}\"}',	'{\"description\":\"Tasks assigned to me\",\"priority\":-10,\"variables\":[{\"name\":\"amount\",\"label\":\"Invoice Amount\"},{\"name\":\"invoiceNumber\",\"label\":\"Invoice Number\"},{\"name\":\"creditor\",\"label\":\"Creditor\"},{\"name\":\"approver\",\"label\":\"Approver\"}]}'),
('b012731c-8f8c-11e4-a486-0a0027000000',	1,	'Task',	'My Group Tasks',	'demo',	'{\"taskCandidateGroupInExpression\":\"${currentUserGroups()}\",\"unassigned\":true}',	'{\"description\":\"Tasks assigned to my Groups\",\"priority\":-5,\"variables\":[{\"name\":\"amount\",\"label\":\"Invoice Amount\"},{\"name\":\"invoiceNumber\",\"label\":\"Invoice Number\"},{\"name\":\"creditor\",\"label\":\"Creditor\"},{\"name\":\"approver\",\"label\":\"Approver\"}]}'),
('b0149600-8f8c-11e4-a486-0a0027000000',	1,	'Task',	'Accounting',	'demo',	'{\"unassigned\":true,\"candidateGroups\":[\"accounting\"]}',	'{\"description\":\"Tasks for Group Accounting\",\"priority\":-5,\"variables\":[{\"name\":\"amount\",\"label\":\"Invoice Amount\"},{\"name\":\"invoiceNumber\",\"label\":\"Invoice Number\"},{\"name\":\"creditor\",\"label\":\"Creditor\"},{\"name\":\"approver\",\"label\":\"Approver\"}]}'),
('b015ce83-8f8c-11e4-a486-0a0027000000',	1,	'Task',	'John\'s Tasks',	'demo',	'{\"assignee\":\"john\"}',	'{\"description\":\"Tasks assigned to John\",\"priority\":-5,\"variables\":[{\"name\":\"amount\",\"label\":\"Invoice Amount\"},{\"name\":\"invoiceNumber\",\"label\":\"Invoice Number\"},{\"name\":\"creditor\",\"label\":\"Creditor\"},{\"name\":\"approver\",\"label\":\"Approver\"}]}'),
('b016dff5-8f8c-11e4-a486-0a0027000000',	1,	'Task',	'Mary\'s Tasks',	'demo',	'{\"assignee\":\"mary\"}',	'{\"description\":\"Tasks assigned to Mary\",\"priority\":-5,\"variables\":[{\"name\":\"amount\",\"label\":\"Invoice Amount\"},{\"name\":\"invoiceNumber\",\"label\":\"Invoice Number\"},{\"name\":\"creditor\",\"label\":\"Creditor\"},{\"name\":\"approver\",\"label\":\"Approver\"}]}'),
('b0177c37-8f8c-11e4-a486-0a0027000000',	1,	'Task',	'Peter\'s Tasks',	'demo',	'{\"assignee\":\"peter\"}',	'{\"description\":\"Tasks assigned to Peter\",\"priority\":-5,\"variables\":[{\"name\":\"amount\",\"label\":\"Invoice Amount\"},{\"name\":\"invoiceNumber\",\"label\":\"Invoice Number\"},{\"name\":\"creditor\",\"label\":\"Creditor\"},{\"name\":\"approver\",\"label\":\"Approver\"}]}'),
('b0186699-8f8c-11e4-a486-0a0027000000',	1,	'Task',	'All Tasks',	'demo',	'{}',	'{\"description\":\"All Tasks - Not recommended to be used in production :)\",\"priority\":-5,\"variables\":[{\"name\":\"amount\",\"label\":\"Invoice Amount\"},{\"name\":\"invoiceNumber\",\"label\":\"Invoice Number\"},{\"name\":\"creditor\",\"label\":\"Creditor\"},{\"name\":\"approver\",\"label\":\"Approver\"}]}');

DROP TABLE IF EXISTS `ACT_RU_IDENTITYLINK`;
CREATE TABLE `ACT_RU_IDENTITYLINK` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_IDENT_LNK_GROUP` (`GROUP_ID_`),
  KEY `ACT_IDX_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_TSKASS_TASK` (`TASK_ID_`),
  CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`),
  CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `ACT_RU_TASK` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `ACT_RU_INCIDENT`;
CREATE TABLE `ACT_RU_INCIDENT` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) NOT NULL,
  `INCIDENT_TIMESTAMP_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `INCIDENT_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `INCIDENT_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ACTIVITY_ID_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CAUSE_INCIDENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `ROOT_CAUSE_INCIDENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_INC_CONFIGURATION` (`CONFIGURATION_`),
  KEY `ACT_IDX_INC_CAUSEINCID` (`CAUSE_INCIDENT_ID_`),
  KEY `ACT_IDX_INC_EXID` (`EXECUTION_ID_`),
  KEY `ACT_IDX_INC_PROCDEFID` (`PROC_DEF_ID_`),
  KEY `ACT_IDX_INC_PROCINSTID` (`PROC_INST_ID_`),
  KEY `ACT_IDX_INC_ROOTCAUSEINCID` (`ROOT_CAUSE_INCIDENT_ID_`),
  CONSTRAINT `ACT_FK_INC_RCAUSE` FOREIGN KEY (`ROOT_CAUSE_INCIDENT_ID_`) REFERENCES `ACT_RU_INCIDENT` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_INC_CAUSE` FOREIGN KEY (`CAUSE_INCIDENT_ID_`) REFERENCES `ACT_RU_INCIDENT` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_INC_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_INC_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`),
  CONSTRAINT `ACT_FK_INC_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `ACT_RU_JOB`;
CREATE TABLE `ACT_RU_JOB` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `LOCK_EXP_TIME_` timestamp NULL DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROCESS_DEF_KEY_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `RETRIES_` int(11) DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DUEDATE_` timestamp NULL DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_TYPE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  `JOB_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_JOB_PROCINST` (`PROCESS_INSTANCE_ID_`),
  KEY `ACT_FK_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`),
  CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


DROP TABLE IF EXISTS `ACT_RU_JOBDEF`;
CREATE TABLE `ACT_RU_JOBDEF` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `PROC_DEF_KEY_` varchar(255) COLLATE utf8_bin NOT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8_bin NOT NULL,
  `JOB_TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `JOB_CONFIGURATION_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `ACT_RU_JOBDEF` (`ID_`, `REV_`, `PROC_DEF_ID_`, `PROC_DEF_KEY_`, `ACT_ID_`, `JOB_TYPE_`, `JOB_CONFIGURATION_`, `SUSPENSION_STATE_`) VALUES
('afef3392-8f8c-11e4-a486-0a0027000000',	1,	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	'invoice',	'ServiceTask_1',	'async-continuation',	'async-before',	1);

DROP TABLE IF EXISTS `ACT_RU_TASK`;
CREATE TABLE `ACT_RU_TASK` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `REV_` int(11) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CASE_EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CASE_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CASE_DEF_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `DELEGATION_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PRIORITY_` int(11) DEFAULT NULL,
  `CREATE_TIME_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `DUE_DATE_` datetime DEFAULT NULL,
  `FOLLOW_UP_DATE_` datetime DEFAULT NULL,
  `SUSPENSION_STATE_` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_TASK_CREATE` (`CREATE_TIME_`),
  KEY `ACT_IDX_TASK_ASSIGNEE` (`ASSIGNEE_`),
  KEY `ACT_FK_TASK_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_TASK_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_TASK_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_TASK_CASE_EXE` (`CASE_EXECUTION_ID_`),
  KEY `ACT_FK_TASK_CASE_DEF` (`CASE_DEF_ID_`),
  CONSTRAINT `ACT_FK_TASK_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `ACT_RE_CASE_DEF` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_CASE_EXE` FOREIGN KEY (`CASE_EXECUTION_ID_`) REFERENCES `ACT_RU_CASE_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `ACT_RE_PROCDEF` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `ACT_RU_TASK` (`ID_`, `REV_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `PROC_DEF_ID_`, `CASE_EXECUTION_ID_`, `CASE_INST_ID_`, `CASE_DEF_ID_`, `NAME_`, `PARENT_TASK_ID_`, `DESCRIPTION_`, `TASK_DEF_KEY_`, `OWNER_`, `ASSIGNEE_`, `DELEGATION_`, `PRIORITY_`, `CREATE_TIME_`, `DUE_DATE_`, `FOLLOW_UP_DATE_`, `SUSPENSION_STATE_`) VALUES
('b01ad7a4-8f8c-11e4-a486-0a0027000000',	1,	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'Assign Approver',	NULL,	'Select the colleague who should approve this invoice.',	'assignApprover',	NULL,	'demo',	NULL,	50,	'2014-12-29 19:58:34',	'2015-01-01 19:58:34',	NULL,	1),
('b0331aa4-8f8c-11e4-a486-0a0027000000',	1,	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'Approve Invoice',	NULL,	'Approve the invoice (or not).',	'approveInvoice',	NULL,	'john',	NULL,	50,	'2014-12-15 19:58:34',	'2014-12-22 19:58:34',	NULL,	1),
('b054856a-8f8c-11e4-a486-0a0027000000',	1,	'b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'invoice:1:afef3391-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	'Review Invoice',	NULL,	'Review the invoice.\n\n\nIf data is missing, provide it.',	'reviewInvoice',	NULL,	'demo',	NULL,	50,	'2014-12-24 19:58:34',	'2014-12-26 19:58:34',	NULL,	1);

DROP TABLE IF EXISTS `ACT_RU_VARIABLE`;
CREATE TABLE `ACT_RU_VARIABLE` (
  `ID_` varchar(64) COLLATE utf8_bin NOT NULL,
  `REV_` int(11) DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CASE_EXECUTION_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `CASE_INST_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint(20) DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8_bin DEFAULT NULL,
  `VAR_SCOPE_` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_VARIABLE` (`VAR_SCOPE_`,`NAME_`),
  KEY `ACT_IDX_VARIABLE_TASK_ID` (`TASK_ID_`),
  KEY `ACT_FK_VAR_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_VAR_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_VAR_BYTEARRAY` (`BYTEARRAY_ID_`),
  KEY `ACT_FK_VAR_CASE_EXE` (`CASE_EXECUTION_ID_`),
  KEY `ACT_FK_VAR_CASE_INST` (`CASE_INST_ID_`),
  CONSTRAINT `ACT_FK_VAR_CASE_INST` FOREIGN KEY (`CASE_INST_ID_`) REFERENCES `ACT_RU_CASE_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `ACT_GE_BYTEARRAY` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_CASE_EXE` FOREIGN KEY (`CASE_EXECUTION_ID_`) REFERENCES `ACT_RU_CASE_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `ACT_RU_EXECUTION` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO `ACT_RU_VARIABLE` (`ID_`, `REV_`, `TYPE_`, `NAME_`, `EXECUTION_ID_`, `PROC_INST_ID_`, `CASE_EXECUTION_ID_`, `CASE_INST_ID_`, `TASK_ID_`, `BYTEARRAY_ID_`, `DOUBLE_`, `LONG_`, `TEXT_`, `TEXT2_`, `VAR_SCOPE_`) VALUES
('b01a897c-8f8c-11e4-a486-0a0027000000',	1,	'string',	'amount',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'30€',	NULL,	'b01a3b5b-8f8c-11e4-a486-0a0027000000'),
('b01a897d-8f8c-11e4-a486-0a0027000000',	1,	'string',	'invoiceNumber',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'GPFE-23232323',	NULL,	'b01a3b5b-8f8c-11e4-a486-0a0027000000'),
('b01a897e-8f8c-11e4-a486-0a0027000000',	1,	'string',	'creditor',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	'b01a3b5b-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Great Pizza for Everyone Inc.',	NULL,	'b01a3b5b-8f8c-11e4-a486-0a0027000000'),
('b02a40f6-8f8c-11e4-a486-0a0027000000',	1,	'string',	'amount',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'312.99$',	NULL,	'b02a19e5-8f8c-11e4-a486-0a0027000000'),
('b02a40f7-8f8c-11e4-a486-0a0027000000',	1,	'string',	'invoiceNumber',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'BOS-43934',	NULL,	'b02a19e5-8f8c-11e4-a486-0a0027000000'),
('b02a40f8-8f8c-11e4-a486-0a0027000000',	1,	'string',	'creditor',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Bobby\'s Office Supplies',	NULL,	'b02a19e5-8f8c-11e4-a486-0a0027000000'),
('b030f7bf-8f8c-11e4-a486-0a0027000000',	1,	'string',	'approver',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	'b02a19e5-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'john',	NULL,	'b02a19e5-8f8c-11e4-a486-0a0027000000'),
('b0369d16-8f8c-11e4-a486-0a0027000000',	1,	'string',	'invoiceNumber',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'PSACE-5342',	NULL,	'b0369d15-8f8c-11e4-a486-0a0027000000'),
('b0369d17-8f8c-11e4-a486-0a0027000000',	1,	'string',	'creditor',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Papa Steve\'s all you can eat',	NULL,	'b0369d15-8f8c-11e4-a486-0a0027000000'),
('b03d2ccd-8f8c-11e4-a486-0a0027000000',	1,	'string',	'approver',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'mary',	NULL,	'b0369d15-8f8c-11e4-a486-0a0027000000'),
('b05066b4-8f8c-11e4-a486-0a0027000000',	1,	'string',	'approved',	'b0369d15-8f8c-11e4-a486-0a0027000000',	'b0369d15-8f8c-11e4-a486-0a0027000000',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'false',	NULL,	'b0369d15-8f8c-11e4-a486-0a0027000000');

-- 2014-12-29 18:59:09
