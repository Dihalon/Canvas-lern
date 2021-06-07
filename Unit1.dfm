object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 395
  ClientWidth = 503
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 24
    Top = 368
    Width = 16
    Height = 13
    Caption = 'lbl1'
  end
  object tmr1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = tmr1Timer
    Left = 440
    Top = 200
  end
  object Timer1: TTimer
    Interval = 33
    OnTimer = Timer1Timer
    Left = 440
    Top = 288
  end
end
