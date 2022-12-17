/** PyQt5 binding for QCustomPlot v2.1.1
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli, Christopher Gilbert
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


class QCPItemRect : public QCPAbstractItem /NoDefaultCtors/
{
%TypeHeaderCode
#include <qcustomplot.h>
%End
public:
  explicit QCPItemRect(QCustomPlot *parentPlot /TransferThis/);
  virtual ~QCPItemRect();
  
  // getters:
  QPen pen() const;
  QPen selectedPen() const;
  QBrush brush() const;
  QBrush selectedBrush() const;
  
  // setters;
  void setPen(const QPen &pen);
  void setSelectedPen(const QPen &pen);
  void setBrush(const QBrush &brush);
  void setSelectedBrush(const QBrush &brush);
  
  // reimplemented virtual methods:
  virtual double selectTest(const QPointF &pos, bool onlySelectable, QVariant *details=0) const;
  
  QCPItemPosition * topLeft
  {
    %GetCode
      return sipConvertFromType(const_cast<::QCPItemPosition*>(sipCpp->topLeft), sipType_QCPItemPosition, NULL);
    %End

    %SetCode
      PyErr_SetString(PyExc_AttributeError, "'topLeft' attribute cannot be assigned");
      sipErr = 1;
    %End
  };
  QCPItemPosition * bottomRight
  {
    %GetCode
      return sipConvertFromType(const_cast<::QCPItemPosition*>(sipCpp->bottomRight), sipType_QCPItemPosition, NULL);
    %End

    %SetCode
      PyErr_SetString(PyExc_AttributeError, "'bottomRight' attribute cannot be assigned");
      sipErr = 1;
    %End
  };
  QCPItemAnchor * top
  {
    %GetCode
      return sipConvertFromType(const_cast<::QCPItemAnchor*>(sipCpp->top), sipType_QCPItemPosition, NULL);
    %End

    %SetCode
      PyErr_SetString(PyExc_AttributeError, "'top' attribute cannot be assigned");
      sipErr = 1;
    %End
  };
  QCPItemAnchor * topRight
  {
    %GetCode
      return sipConvertFromType(const_cast<::QCPItemAnchor*>(sipCpp->topRight), sipType_QCPItemPosition, NULL);
    %End

    %SetCode
      PyErr_SetString(PyExc_AttributeError, "'topRight' attribute cannot be assigned");
      sipErr = 1;
    %End
  };
  QCPItemAnchor * right
  {
    %GetCode
      return sipConvertFromType(const_cast<::QCPItemAnchor*>(sipCpp->right), sipType_QCPItemPosition, NULL);
    %End

    %SetCode
      PyErr_SetString(PyExc_AttributeError, "'right' attribute cannot be assigned");
      sipErr = 1;
    %End
  };
  QCPItemAnchor * bottom
  {
    %GetCode
      return sipConvertFromType(const_cast<::QCPItemAnchor*>(sipCpp->bottom), sipType_QCPItemPosition, NULL);
    %End

    %SetCode
      PyErr_SetString(PyExc_AttributeError, "'bottom' attribute cannot be assigned");
      sipErr = 1;
    %End
  };
  QCPItemAnchor * bottomLeft
  {
    %GetCode
      return sipConvertFromType(const_cast<::QCPItemAnchor*>(sipCpp->bottomLeft), sipType_QCPItemPosition, NULL);
    %End

    %SetCode
      PyErr_SetString(PyExc_AttributeError, "'bottomLeft' attribute cannot be assigned");
      sipErr = 1;
    %End
  };
  QCPItemAnchor * left
  {
    %GetCode
      return sipConvertFromType(const_cast<::QCPItemAnchor*>(sipCpp->left), sipType_QCPItemPosition, NULL);
    %End

    %SetCode
      PyErr_SetString(PyExc_AttributeError, "'left' attribute cannot be assigned");
      sipErr = 1;
    %End
  };

protected:
  // reimplemented virtual methods:
  virtual void draw(QCPPainter *painter);
  virtual QPointF anchorPixelPosition(int anchorId) const;

  // non-virtual methods:
  QPen mainPen() const;
  QBrush mainBrush() const;
};
