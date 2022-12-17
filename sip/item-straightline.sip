/** PyQt5 binding for QCustomPlot v2.1.1
 *
 *  Authors: Dmitry Voronin, Giuseppe Corbelli, Christopher Gilbert
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


class QCPItemStraightLine : public QCPAbstractItem /NoDefaultCtors/
{
%TypeHeaderCode
#include <qcustomplot.h>
%End
public:
  explicit QCPItemStraightLine(QCustomPlot *parentPlot /TransferThis/);
  virtual ~QCPItemStraightLine();
  
  // getters:
  QPen pen() const;
  QPen selectedPen() const;

  // setters;
  void setPen(const QPen &pen);
  void setSelectedPen(const QPen &pen);
  
  // reimplemented virtual methods:
  virtual double selectTest(const QPointF &pos, bool onlySelectable, QVariant *details=0) const;

  // There's nothing like 'const' in python
  QCPItemPosition *point1
  {
    %GetCode
      return sipConvertFromType(const_cast<::QCPItemPosition*>(sipCpp->point1), sipType_QCPItemPosition, NULL);
    %End

    %SetCode
      PyErr_SetString(PyExc_AttributeError, "'point1' attribute cannot be assigned");
      sipErr = 1;
    %End
  };
  QCPItemPosition *point2
  {
    %GetCode
      return sipConvertFromType(const_cast<::QCPItemPosition*>(sipCpp->point2), sipType_QCPItemPosition, NULL);
    %End

    %SetCode
      PyErr_SetString(PyExc_AttributeError, "'point2' attribute cannot be assigned");
      sipErr = 1;
    %End
  };

protected:
  // reimplemented virtual methods:
  virtual void draw(QCPPainter *painter);

  // non-virtual methods:
  QLineF getRectClippedStraightLine(const QCPVector2D &point1, const QCPVector2D &vec, const QRect &rect) const;
  QPen mainPen() const;
};
