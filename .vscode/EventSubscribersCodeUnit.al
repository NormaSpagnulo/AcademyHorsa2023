codeunit 50101 "Test Eventi"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnBeforePostSalesDoc, '', false, false)]
    local procedure OnBeforePostSalesDoc(var Sender: Codeunit "Sales-Post"; var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; PreviewMode: Boolean; var HideProgressWindow: Boolean; var IsHandled: Boolean);
    begin

        SalesHeader.TestField("Bill-to Customer No."); // dico prima di compilare, vedi se c'è il cliente
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterCopyBuyFromVendorFieldsFromVendor', '', false, false)]
    local procedure OnAfterCopyBuyFromVendorFieldsFromVendor(var PurchaseHeader: Record "Purchase Header"; Vendor: Record Vendor; xPurchaseHeader: Record "Purchase Header");
    begin

        PurchaseHeader."Last Name" := Vendor."Last Name";

    end;

    [EventSubscriber(ObjectType::Report, Report::"Combine Shipments", 'OnAfterInsertSalesInvHeader', '', false, false)]
    local procedure OnAfterInsertSalesInvHeader_Uno(var SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header");
    begin
        SalesHeader.TestField("Bill-to Customer No.");
    end;

    [EventSubscriber(ObjectType::Report, Report::"Combine Shipments", 'OnAfterInsertSalesInvHeader', '', false, false)]
    local procedure OnAfterInsertSalesInvHeader_Due(var SalesHeader: Record "Sales Header"; var SalesShipmentHeader: Record "Sales Shipment Header");
    begin
        SalesHeader."Salesperson Code" := 'GINO';
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnCopyToTempLinesLoop, '', false, false)]
    local procedure OnCopyToTempLinesLoop(var PurchLine: Record "Purchase Line");
    begin
    end;

    [EventSubscriber(ObjectType::Page, Page::"Apply Vendor Entries", 'OnBeforeRunVendEntryEdit', '', false, false)]
    local procedure OnBeforeRunVendEntryEdit(var Sender: Page "Apply Vendor Entries"; var VendorLedgerEntry: Record "Vendor Ledger Entry");
    begin
    end;

}